class AddAutoIncrementToOpportunityId < ActiveRecord::Migration[5.0]
  def change
   
   execute <<-SQL
     CREATE SEQUENCE opportunity_id_seq;
     ALTER TABLE "public"."opportunity" ALTER COLUMN "opportunity_id" SET DEFAULT nextval('opportunity_id_seq'::regclass);
   SQL
  end
end
