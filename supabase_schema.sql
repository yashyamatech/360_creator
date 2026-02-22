-- 360 Creator - Supabase PostgreSQL Schema
-- Run this in your Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- VIDEOS POSTS TABLE
-- ============================================================
CREATE TABLE videos_posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  video_url VARCHAR(500) NOT NULL,
  thumbnail_url VARCHAR(500),
  agency_id UUID NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  views INT DEFAULT 0,
  likes INT DEFAULT 0,
  video_type VARCHAR(50) CHECK (video_type IN ('creation', 'editing', 'both')),
  hashtags TEXT[],
  actor_names TEXT[],
  client_name VARCHAR(255),
  project_duration VARCHAR(100),
  budget_range VARCHAR(100)
);

-- ============================================================
-- INQUIRIES TABLE
-- ============================================================
CREATE TABLE inquiries (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  project_type VARCHAR(50) NOT NULL CHECK (project_type IN ('Video Creation', 'Video Editing', 'Both')),
  message TEXT,
  budget_range VARCHAR(100),
  timeline VARCHAR(100),
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'reviewed', 'contacted')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- BOOKINGS TABLE
-- ============================================================
CREATE TABLE bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  reference_video_id UUID REFERENCES videos_posts(id) ON DELETE SET NULL,
  project_requirements TEXT,
  budget VARCHAR(100),
  timeline VARCHAR(100),
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- AGENCY INFO TABLE
-- ============================================================
CREATE TABLE agency_info (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  company_name VARCHAR(255) NOT NULL,
  description TEXT,
  phone_number VARCHAR(20),
  email VARCHAR(255),
  address TEXT,
  website VARCHAR(255),
  instagram_url VARCHAR(255),
  facebook_url VARCHAR(255),
  youtube_url VARCHAR(255),
  linkedin_url VARCHAR(255),
  team_members JSONB DEFAULT '[]'::jsonb,
  testimonials JSONB DEFAULT '[]'::jsonb,
  mission_statement TEXT,
  vision_statement TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- STORED PROCEDURES (for likes/views)
-- ============================================================

-- Increment video views
CREATE OR REPLACE FUNCTION increment_video_views(post_id UUID)
RETURNS VOID AS $$
  UPDATE videos_posts SET views = views + 1 WHERE id = post_id;
$$ LANGUAGE SQL;

-- Increment video likes
CREATE OR REPLACE FUNCTION increment_video_likes(post_id UUID)
RETURNS VOID AS $$
  UPDATE videos_posts SET likes = likes + 1 WHERE id = post_id;
$$ LANGUAGE SQL;

-- Decrement video likes (ensure non-negative)
CREATE OR REPLACE FUNCTION decrement_video_likes(post_id UUID)
RETURNS VOID AS $$
  UPDATE videos_posts SET likes = GREATEST(likes - 1, 0) WHERE id = post_id;
$$ LANGUAGE SQL;

-- ============================================================
-- AUTO-UPDATE TIMESTAMPS TRIGGER
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_videos_posts_updated_at
  BEFORE UPDATE ON videos_posts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_inquiries_updated_at
  BEFORE UPDATE ON inquiries
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_bookings_updated_at
  BEFORE UPDATE ON bookings
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================

-- Enable RLS
ALTER TABLE videos_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE inquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE agency_info ENABLE ROW LEVEL SECURITY;

-- Videos posts: public read, no public write
CREATE POLICY "Videos are publicly readable"
  ON videos_posts FOR SELECT
  USING (true);

-- Agency info: public read
CREATE POLICY "Agency info is publicly readable"
  ON agency_info FOR SELECT
  USING (true);

-- Inquiries: public insert (anyone can submit), no public read
CREATE POLICY "Anyone can submit inquiries"
  ON inquiries FOR INSERT
  WITH CHECK (true);

-- Bookings: public insert only
CREATE POLICY "Anyone can submit bookings"
  ON bookings FOR INSERT
  WITH CHECK (true);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- Insert sample agency info
INSERT INTO agency_info (
  company_name, description, phone_number, email, address, website,
  instagram_url, facebook_url, youtube_url, linkedin_url,
  mission_statement, vision_statement,
  team_members, testimonials
) VALUES (
  '360 Creator',
  'We are a creative agency specializing in social media content creation and video production. Our team of talented actors and filmmakers bring your brand story to life.',
  '+1 (555) 360-0001',
  'info@360creator.com',
  '123 Creator Street, Los Angeles, CA 90001',
  'https://360creator.com',
  'https://instagram.com/360creator',
  'https://facebook.com/360creator',
  'https://youtube.com/360creator',
  'https://linkedin.com/company/360creator',
  'To empower brands through compelling visual storytelling that resonates with modern audiences.',
  'To be the leading creative force in social media content, setting trends and inspiring creativity worldwide.',
  '[
    {"name": "Alex Johnson", "role": "Creative Director", "bio": "Award-winning director with 10+ years in commercial and social media production."},
    {"name": "Sarah Chen", "role": "Lead Video Editor", "bio": "Expert in post-production with a passion for storytelling through editing."},
    {"name": "Marcus Williams", "role": "Content Strategist", "bio": "Social media specialist with proven track record of viral campaigns."}
  ]'::jsonb,
  '[
    {"client_name": "Jennifer Park", "company": "FashionForward Inc.", "message": "360 Creator transformed our brand identity. Our engagement increased by 300%!", "rating": 5, "project_type": "Video Creation"},
    {"client_name": "David Rodriguez", "company": "TechStart Labs", "message": "Outstanding editing quality and attention to detail. They truly understood our vision.", "rating": 5, "project_type": "Video Editing"},
    {"client_name": "Emma Thompson", "company": "Lifestyle Brands Co.", "message": "Working with 360 Creator was a game-changer. Their creative approach made our products shine.", "rating": 4.5, "project_type": "Both"}
  ]'::jsonb
);

-- Insert sample video posts
INSERT INTO videos_posts (title, description, video_url, thumbnail_url, agency_id, views, likes, video_type, hashtags, actor_names, client_name, project_duration, budget_range) VALUES
(
  'Brand Campaign - Summer Collection',
  'An energetic campaign showcasing the summer fashion line with dynamic actors and vibrant locations.',
  'https://example.com/videos/summer-campaign.mp4',
  'https://picsum.photos/seed/video1/400/300',
  uuid_generate_v4(),
  15420, 1230, 'creation',
  ARRAY['#summer', '#fashion', '#brand', '#campaign'],
  ARRAY['Sarah M.', 'Jake T.'],
  'FashionForward Inc.',
  '3 weeks',
  '$5,000 - $10,000'
),
(
  'Product Launch - Tech Startup',
  'Sleek and modern product video highlighting innovative features for a leading tech startup.',
  'https://example.com/videos/tech-launch.mp4',
  'https://picsum.photos/seed/video2/400/300',
  uuid_generate_v4(),
  8930, 567, 'editing',
  ARRAY['#tech', '#startup', '#innovation', '#product'],
  ARRAY['Alex R.'],
  'TechStart Labs',
  '1 week',
  '$1,000 - $5,000'
),
(
  'Restaurant Promo - Fine Dining',
  'A cinematic journey through culinary excellence showcasing signature dishes.',
  'https://example.com/videos/restaurant-promo.mp4',
  'https://picsum.photos/seed/video3/400/300',
  uuid_generate_v4(),
  22150, 1890, 'both',
  ARRAY['#food', '#finedining', '#restaurant', '#culinary'],
  ARRAY['Emma L.', 'Marcus J.'],
  'Le Gourmet Restaurant',
  '2 weeks',
  '$5,000 - $10,000'
);
