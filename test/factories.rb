FactoryGirl.define do

  factory :tournament do
    name "Project CHUCK Summer Tournament"
    description "Continuously Helping to Uplift City Kids"
    start_date 1.years.ago.to_date
    end_date nil
    active true
  end

  factory :bracket do
    association :tournament
    gender "male"
    min_age 7
    max_age 10
    max_students 100
    name "Boys 7-10"
    active true
  end
  
  factory :team do
    association :bracket
    name "Steelers"
    max_students 10
    num_wins 0
    num_losses 0
  end

  factory :games do
    date Date.today
  end

  factory :volunteer do
    association :user
    association :team
    role "Volunteer"
    email "pranz@cmu.edu"
    first_name "Pranita"
    last_name "Ramakrishnan"
    cell_phone "571-478-3829"
    receives_text_msgs true
    active true
    dob Date.today
    date Date.today
    street "5000 Forbes Ave"
    city "Pittsburgh"
    state "PA"
    zip 15213
    day_phone 1234567890
    shirt_size "M"
    years_with_proj_chuck 0
    position "helper"
    team_coached "Team One"
    child_name "Jack"
    clearance_copy "image.jpg"
    not_available "text"
    two_skills "managing and cleaning"
    suggestions "no suggestions"
    volunteer_sign "Pranita Ramakrishnan"
    volunteer_sign_date Date.today
    act33_clearance true
    act34_clearance true
    act153_clearance true
    gender "female"
    age_range "18-25"
  end

  factory :user do
    username "user123"
    role "volunteer"
    email "user123@user.com"
    password "secret"
    password_confirmation "secret"
    active_after Date.today
    password_reset_token "89ok"
    password_reset_sent_at Date.today
    active true
  end

  factory :team_game do
    association :game
    association :team
    score nil
  end

  factory :school do
   name "Park Elementary School"
   district "Steel Valley"
   county "Allegheny"
  end

  factory :guardian do
    association :household
    association :user
    email "name@cmu.edu"
    first_name "Jane"
    last_name "Doe"
    cell_phone "412-678-9000"
    receives_text_msgs true
    relation "Mother"
    is_emergency_contact true
    active true
  end

  factory :household do
    street "100 Main St"
    city "Pittsburgh"
    state "PA"
    zip "15213"
    home_phone "412-000-0000"
    county "Allegheny"
    has_proof_of_insurance true
    insurance_provider "UPMC"
    insurance_policy_no "12345678"
    family_physicians "physician"
    physician_phone "4124124124"
    proof_of_insurance "image.jpg"
    poi_checkoff true
    active true
  end

  factory :student do
    association :household
    association :school
    first_name "Joe"
    last_name "Smith"
    dob 8.years.ago.to_date
    cell_phone "4120000000"
    email "joe_smith@comcast.net"
    grade 9
    gender "male"
    allergies "none"
    medications "none"
    active true
    jersey_size "Youth-Medium"
    gpa "4.0"
    past_participation 0
    twitter "joe_smith"
    facebook "joe_smith"
    instagram "joe_smith"
  end
  
  factory :document do
    association :student
    document "img_2016.jpg"
    doc_type "report card"
  end

  factory :registration do
    association :student
    association :bracket
    active true
  end

  factory :roster_spot do
    association :team
    association :student
    jersey_number 1
    active true
  end

end
