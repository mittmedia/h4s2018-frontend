class TopicsController < ApplicationController
  def index
    @topics = [
      OpenStruct.new({
        id: 1,
        type: 'card',
        title: 'Some topic name that is very interesting for you right now.',
        stage: 'Stage 6: voting',
        category: 'School',
        created_at: Date.today
      }),
      OpenStruct.new({
        type: 'trending',
        cards: [OpenStruct.new({
          id: 4,
          type: 'card',
          title: 'A trending topic that is probably going to be interesting for you.',
          category: 'Health',
          stage: 'Stage 6: voting',
          created_at: Date.today
        }),
        OpenStruct.new({
          id: 5,
          type: 'card',
          title: 'Another article that is trending.',
          category: 'Privacy',
          stage: 'Stage 6: voting',
          created_at: Date.today
        })]
      }),
      OpenStruct.new({
        id: 2,
        type: 'card',
        title: 'Some other topic you will be less interested in.',
        stage: 'Stage 2: proposal',
        category: 'Finance',
        created_at: Date.today
      }),
      OpenStruct.new({
        id: 3,
        type: 'card',
        title: 'A weird topic you would want to follow, this will break democracy for sure.',
        stage: 'Stage 1: investigation',
        category: 'Immigration',
        created_at: Date.today
      })
    ]
  end

  def show
    @documents = Api::Document.all
  end
end
