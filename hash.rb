require "csv"

$SrcFileName = "merged2016"
$SrcDir = "#{$SrcFileName}.csv"
$HashTableDir = "nodes.csv"
$HashedOutputDir ="links.csv"
# $HashTableDir = "#{$SrcFileName}_HashTable.csv"
# $HashedOutputDir ="#{$SrcFileName}_Hashed.csv"

udids = {}
udids_name = {}
unique_count = 0

hashed_csv = CSV.open($HashedOutputDir, "w")
hash_table_csv = CSV.open($HashTableDir, "w")

# CSV.foreach("fotoUnique.csv") do |row|
#   val = row[0]
#   if udids[val.to_sym]
#     row[0] = udids[val.to_sym]
#   else
#     udids[val.to_sym] = unique_count
#     row[0] = unique_count
#     unique_count += 1
#   end
# end

i = 0

hash_table_csv << ["node"]

CSV.foreach($SrcDir) do |row|

  if i == 0
    hashed_csv << ["source", "target", "strength", "month", "weight"]
    i = i + 1
    next
  end
  
  val = row[0]
  if udids[val.to_sym]
    # row[0] = udids[val.to_sym]
  else
    udids[val.to_sym] = unique_count
    # row[0] = unique_count

    hash_table_csv << [val]

    unique_count += 1
  end

  val = row[1]
  if udids[val.to_sym]
    # row[1] = udids[val.to_sym]
  else
    udids[val.to_sym] = unique_count
    # row[1] = unique_count

    hash_table_csv << [val]

    unique_count += 1
  end

  # if row[2].to_f > 0
  #   row << 0
  # else
  #   row << 1
  # end

  row << row[2].to_f.abs;

  hashed_csv << row
end


hash_table_csv.close
hashed_csv.close