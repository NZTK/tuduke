module ApplicationHelper
	def resource_name
   		:user
	end
   def all_likes_count(novel)
   	sum =0
   	novel.novel_content.each do |con|
   		#sum = sum + con.likes.count
   		sum += con.likes.count
   	end
   	return sum
   end
      def all_comments_count(novel)
   	sum =0
   	novel.novel_content.each do |con|
   		#sum = sum + con.likes.count
   		sum += con.comments.count
   	end
   	return sum
   end

   def all_views_count(novel)
   	sum =0
   	novel.novel_content.each do |con|
   		#sum = sum + con.likes.count
   		sum += con.impressions_count
   	end
   	return sum
   end

def resource
   @resource ||= User.new
end

def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
end
end
