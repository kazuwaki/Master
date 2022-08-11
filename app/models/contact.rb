class Contact < ApplicationRecord
  enum subject: { other: 0, work: 1, recruit: 2, method: 3 }
end
