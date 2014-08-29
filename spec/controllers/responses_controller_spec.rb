require 'rails_helper'

describe ResponsesController do
  let(:prompt){ Prompt.create(title: "22 Jump Street", description: "Who's the mexican wolverine?" ) }
  let(:response){ Response.new(body: "His name is Sleepy!") }
  it "should create a new Response Object with valid params" do
    expect{
      post :create,
      :prompt_id => prompt.id,
      :response => {
        :body => response.body
      }
    }.to change{ prompt.responses.count }.by(1)
  end
end
