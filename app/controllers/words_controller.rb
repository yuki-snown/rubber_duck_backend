
require 'natto'
require 'securerandom'

# debugger => binding.pry

class WordsController < ApplicationController
    def health
        render json: {'msg': "OK"}, :status => 200  
    end

    def search
        surface = []
        feature = []
        natto = Natto::MeCab.new
        key = ''
        pattern = ''
        flag = false

        # 言語処理系 一致するkey, patternを抽出 or resp文章を作成
        natto.parse(params[:text]) do |n|
            if n.surface.include?("可愛い") then
                flag = true
                surface.push("えへへー")
                break
            elsif n.surface.include?("すごい") then
                flag = true
                surface.push("でしょ！")
                break
            elsif n.feature.split(',')[0] == "感動詞" then
                flag = true
                surface.push("#{n.surface}！！")
                break
            elsif n.surface.include?("ひより") then
                flag = true
                surface.push("はーい！！")
                break
            elsif n.surface.include?("ない") && surface[-1].include?("でき") then
                flag = true
                surface.push("どうして，#{surface[-2]}ができないの？")
                break
            elsif (n.feature.split(',')[0] == "形容詞") || (n.feature.split(',')[0] == "動詞") then
                key = "#{n.surface}"
                pattern = "#{surface[-1]}#{n.surface}"
            end
            surface.push(n.surface)
            feature.push(n.feature.split(',')[0])
        end

        # 検索とrespの処理系
        if flag then
            render json: {'msg': "#{surface[-1]}"}, :status => 200
        else
            msg =  Word.order(rank: :desc).find_by(key: [key, '*'], pattern: [pattern, '*'])
            if msg.present? then
                render json: {'msg': "#{msg.message}"}, :status => 200                
            else
                rnd = SecureRandom.random_number(3)
                if surface.length < 4 then
                    render json: {'msg': "だよね！"}, :status => 200
                elsif rnd = 0
                    render json: {'msg': "もう少し教えて！"}, :status => 200
                elsif rnd = 1
                    render json: {'msg': "他には？？"}, :status => 200
                elsif rnd = 2
                    render json: {'msg': "気分転換でもしたら？"}, :status => 200
                end
            end
        end
    end
end