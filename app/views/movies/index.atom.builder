atom_feed do |feed|
  feed.title 'Movies'
  feed.updated @movies.maximum(:updated_at)

  @movies.each do |movie|
    feed.entry movie, published: movie.created_at do |entry|
      entry.title movie.name
    end
  end
end
