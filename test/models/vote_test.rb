require "test_helper"

describe Vote do

  describe 'validations' do
    before do
      user = User.create(username: 'test username')
      work = Work.create(category: 'movie', title: 'test title', creator: 'test creator', publication_year: 2018, description: 'test description' )

      @vote = Vote.new(user_id: user.id, work_id: work.id)

    end

    it 'is valid when all fields are present' do
      result = @vote.valid?
      result.must_equal true
    end

    it 'is invalid without a user_id' do
      @vote.user_id = nil
      result = @vote.valid?
      result.must_equal false
      @vote.errors.messages.must_include :user_id
    end

    it 'is invalid without a work_id' do
      @vote.work_id = nil
      result = @vote.valid?
      result.must_equal false
      @vote.errors.messages.must_include :work_id
    end

    it 'is invalid with a duplicate vote' do
      dup_vote = Vote.first
      @vote.user_id = dup_vote.user_id
      @vote.work_id = dup_vote.work_id

      result = @vote.valid?
      result.must_equal false
      @vote.errors.messages.must_include :user_id
    end
  end

  describe 'relations' do

    it 'has a user' do
      vote = votes(:book_vote)
      vote.user.must_equal users(:luke)
    end

    it 'can set the user' do
      vote = Vote.new()
      vote.user = users(:luke)
      vote.user_id.must_equal users(:luke).id
    end

    it 'has a work' do
      vote = votes(:book_vote)
      vote.work.must_equal works(:kindred)
    end

    it 'can set the work' do
      vote = Vote.new()
      vote.work = works(:kindred)
      vote.work_id.must_equal works(:kindred).id
    end

  end

end
