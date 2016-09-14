class AssistantController < ApplicationController
  def messenger
    query = (params[:result][:parameters]['any'].present?)? params[:result][:parameters]['any'] : "Ruby On Rails"
    page = WikipediaConsulter.find_by_name(query)

    text = (page.text.present?)? page.text.slice(0, 120) : ''
    p page.image_urls
    response =
    {
      "speech": "#{text}... \b link completo: #{page.fullurl}",
      "displayText": "#{text}... \b link completo: #{page.fullurl}",
      "data": {"facebook": {
        "attachment":{
        "type":"image",
        "payload":{
          "url": page.image_urls.first
          }
        }
      },
      "source": "Programming Assitant"
    }

    render json: response
  end
end
