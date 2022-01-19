class ThingsBrain
  def initialize(objects)
    @objects = objects
  end

  def tell_all_about_all
    @objects.each do |me|
      next if me.info_you_should_know_about_me.nil?

      tell_them_about_me = @objects.reject { |e| e == me }
      tell_them_about_me.each do |obj|
        obj.i_know_about(me.info_you_should_know_about_me)
      end
    end
    # @objects.detect { |obj| obj.instance_of?(AppleHandler) }.i_know_about(free_places)
  end
end
