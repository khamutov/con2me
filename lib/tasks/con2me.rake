namespace :con2me do
  desc "TODO"
  task gen_visitors: :environment do
    (1..5000).each do
      visitors = []
      (1..1000).each do
        visitors << Visitor.new(:os => Forgery('browser').os,
                        :browser => Forgery('browser').browser,
                        :date => Forgery('browser').visit_date,
                        :cookie => Forgery('browser').cookie,
                        :source => Forgery('browser').source
        )
      end
      Visitor.import visitors, :validate => false
    end
  end

  desc "TODO"
  task randomize: :environment do
    Offer.all.each do |offer|
      offer.created_at = Forgery('browser').visit_date
      offer.save!
    end
  end

end
