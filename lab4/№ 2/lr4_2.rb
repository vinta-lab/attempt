module Resource
  def connect(routes)
    if routes.nil?
      puts "No route matches for #{self}"
      return
    end

    loop do
      print 'Choose request (GET/POST/PUT/DELETE) or ' + 'q' + " - exit: \n\n"
      request = gets.chomp.upcase!
      break if request == 'q'

      if (request != 'GET') && (request != 'POST') && (request != 'PUT') && (request != 'DELETE') && (request != 'q')
        puts 'Command is not correct'
      end

      operation = nil

      if request == 'GET'
        print 'Choose operation (index/show) or "q" - exit: '
        operation = gets.chomp
        break if operation == 'q'
      end
      operation.nil? ? routes[request].call : routes[request][operation].call
    end
  end
end

class PostsController
  extend Resource
  def initialize
    @posts = []
  end

  def index
    if @posts.empty?
      puts 'No post found'
    else
      @posts.each.with_index { |value, key| puts "id: #{key} body: #{value}" }
    end
  end

  def show
    print "\nEnter post id: "
    index = gets.chomp.to_i
    if @posts.size > index && index >= 0
      puts "\nPost with id #{index}\n#{@posts[index]}"
    else puts "Post with id #{index} - not found!\n\n"
    end
  end

  def create
    puts 'Enter post description: '
    body = gets
    @posts.push(body)
  end

  def update
    print 'Enter post id to update: '
    index = gets.chomp.to_i
    body = nil
    puts 'Enter post description: '
    body = gets
    @posts[index] = body
    self.index
  end

  def destroy
    print 'Post id: '
    index = gets.chomp.to_i
    if @posts.size > index
      @posts.delete_at(index)
    else puts "Post not found\n"
    end
  end
end

class CommentsController
  extend Resource
  def initialize
    @comments = {}
  end

  def index
    if @comments.empty?
      puts 'Comments not found'
    else
      @comments.each do |key, value|
        puts "post id: #{key}\n"
        value.each.with_index do |vl, i|
          puts "comment id: #{i} comment: #{vl}"
        end
      end
    end
  end

  def show
    puts 'Post id: '
    id_post = gets.chomp.to_i
    if @comments.key?(id_post)
      @comments[id_post].each.with_index { |value, id| puts "comment id: #{id} comment: #{value}" }
    else puts 'No comments found'
    end
  end

  def create
    print 'Post id: '
    id_post = gets.chomp.to_i
    puts 'Text comment: '
    message = gets
    if @comments.key?(id_post)
      @comments[id_post].push(message)
    else
      @comments.store(id_post, [message])
    end
    index
  end

  def update
    puts 'Post id: '
    id_post = gets.chomp.to_i
    puts 'Text comment: '
    message = gets
    @comments.store(id_post, [message])
  end

  def destroy
    print 'Post id to delete: '
    id_post = gets.chomp.to_i
    @comments.delete(id_post)
  end
end

class Router
  def initialize
    @routes = {}
  end

  def init
    resources(PostsController, 'posts')
    resources(CommentsController, 'comments')

    loop do
      print 'Choose resource (1 - Posts, 2 - Comments, q - Exit): '
      choise = gets.chomp

      PostsController.connect(@routes['posts']) if choise == '1'
      CommentsController.connect(@routes['comments']) if choise == '2'
      break if choise == 'q'
    end
  end

  def resources(clas, keyword)
    controller = clas.new
    @routes[keyword] = {
      'GET' => {
        'index' => controller.method(:index),
        'show' => controller.method(:show)
      },
      'POST' => controller.method(:create),
      'PUT' => controller.method(:update),
      'DELETE' => controller.method(:destroy)
    }
  end
end

router = Router.new

router.init