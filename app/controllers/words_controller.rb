
require 'natto'

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

        natto.parse(params[:text]) do |n|
            if n.feature.include?("感動詞") then
                flag = true
                surface.push(n.surface)
                break
            elsif n.feature.include?("形容詞") || n.feature.include?("動詞") 
                key = "#{n.surface}"
                pattern = "#{surface[-1]}#{n.surface}"
            end
            surface.push(n.surface)
            feature.push(n.feature.split(',')[0])
        end

        if flag then
            render json: {'msg': "#{surface[-1]}"}, :status => 200
        else
            binding.pry
            msg =  Word.order(rank: :desc).find_by(key: [key, '*'], pattern: [pattern, '*'])
            if msg.present? then
                render json: {'msg':msg.message}, :status => 200                
            else
                render json: {'msg': "すいません．分かりません"}, :status => 200                
            end    
        end
    end
end