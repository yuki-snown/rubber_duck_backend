class WordsController < ApplicationController
    def search
        begin
            # debugger
            #binding.pry
            msg =  Word.order(rank: :desc).find_by(key: params[:key], pattern: [params[:pattern], '*'])
            if msg.present? then
                render json: {'msg':msg.message}, :status => 200                
            else
                render json: {'msg': "すいません．分かりません"}, :status => 200                
            end
        rescue => exception
            render json: {'msg': 'Bad Request'}, :status => 500
        end
    end
end