-- SQL SEED File generated on 2025-07-26T04:06:19.177Z


DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS plant_layout;
DROP TABLE IF EXISTS layouts;
DROP TABLE IF EXISTS favorite_plants;
DROP TABLE IF EXISTS plant_Design_Types;
DROP TABLE IF EXISTS fave_design;
DROP TABLE IF EXISTS plants;
DROP TABLE IF EXISTS designs;
DROP TABLE IF EXISTS users;


CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users(
    id UUID PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    is_admin BOOLEAN DEFAULT false NOT NULL
);

CREATE TABLE designs(
    id UUID PRIMARY KEY,
    design_style_name VARCHAR(50) UNIQUE NOT NULL,
    design_attributes VARCHAR(255),    -- short description
    design_description TEXT,           -- long description
    design_tags TEXT                   -- tags
);

CREATE TABLE IF NOT EXISTS plants (
    id UUID PRIMARY KEY,
    plant_name VARCHAR(255) UNIQUE NOT NULL,
    other_common_names TEXT,
    technical_name VARCHAR(255),
    growth_form VARCHAR(50),
    is_toxic BOOLEAN DEFAULT false NOT NULL,
    sun_requirements TEXT,
    height_min_ft NUMERIC(5, 2),
    height_max_ft NUMERIC(5, 2),
    width_min_ft NUMERIC(5, 2),
    width_max_ft NUMERIC(5, 2),
    seasonal_interest TEXT,
    primary_color VARCHAR(50),
    accent_color VARCHAR(50),
    image_url TEXT
);

CREATE TABLE favorite_plants(
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    plant_id UUID REFERENCES plants(id),
    CONSTRAINT user_and_plant_id UNIQUE(user_id, plant_id)
);

CREATE TABLE plant_Design_Types(
    id UUID PRIMARY KEY,
    plant_id UUID REFERENCES plants(id),
    design_id UUID REFERENCES designs(id),
    UNIQUE (plant_id, design_id)
);


CREATE TABLE projects(
    id UUID PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    user_id UUID REFERENCES users(id)
);

CREATE TABLE layouts(
    id UUID PRIMARY KEY,
    layout_name varchar(100) NOT NULL,
    bed_length INTEGER NOT NULL,
    bed_depth INTEGER NOT NULL,
    design_type UUID REFERENCES designs(id),
    projects_id UUID REFERENCES projects(id)
);

CREATE TABLE plant_layout(
    id UUID PRIMARY KEY,
    plant_id UUID REFERENCES plants(id),
    layout_id UUID REFERENCES layouts(id),
    x_coord NUMERIC(10, 2) NOT NULL,
    y_coord NUMERIC(10, 2) NOT NULL,
    diameter NUMERIC(5, 2) NOT NULL,
    height NUMERIC(5, 2) NOT NULL
);

CREATE TABLE fave_design(
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    design_id UUID REFERENCES designs(id)
);


-- Users Inserts
INSERT INTO users (id, username, password, is_admin) VALUES ('22575560-a367-42e3-9bf0-49a5a7c8ddbc', 'Justin', '$2b$07$bwxQezgDuM4J73FwG/IC8uWpwoXLA4eRJzhICoLPDRIu5NKhltCaa', TRUE) ON CONFLICT (id) DO NOTHING;
INSERT INTO users (id, username, password, is_admin) VALUES ('069ea174-5ecb-4703-85c2-49c7286d93bc', 'Chelsea', '$2b$07$01JzaT4Ax.Qz99jgbwNtx.NdZPEXqlLyYVo9T7ubA7nyfYL6w6xBS', TRUE) ON CONFLICT (id) DO NOTHING;
INSERT INTO users (id, username, password, is_admin) VALUES ('210954a1-1d49-4fec-a81f-92738276115f', 'Callen', '$2b$07$GQ4Hth7jH35ilu0ewm9bzemDFMPuG3AqNQHYUpZ7j5wgXGudsqzM2', TRUE) ON CONFLICT (id) DO NOTHING;
INSERT INTO users (id, username, password, is_admin) VALUES ('3b982c64-4293-48e3-a9cb-bc98e0df3e5b', 'Ellie', '$2b$07$GZzWuQ3b/idlvUSmsL9uLOsLGYlsz6s7h4R099ikEVuYnnMfdcr2u', TRUE) ON CONFLICT (id) DO NOTHING;

-- Designs Inserts
INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '213f3124-3729-4bae-af4f-43b720e6b5df',
  'modern minimalism',
  'A sleek, refined space defined by sculptural plants, white space, and minimal materials. Focused on balance, simplicity, and restraint.',
  'A Modern Minimalism garden distills modern design to its purest form. It emphasizes sculptural simplicity, white space, and deliberate restraint in both planting and materials. With sparse, architectural elements and a limited palette, the space feels quiet and refined. Negative space is used as intentionally as the plantings, celebrating geometry, balance, and thoughtful reduction.',
  'linear, asymmetrical, informal hierarchy, odd spacing, abstraction, rhythm, massing, limited palette, white space, focus on restraint, sparce, sculptural'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  'ea3e1e8e-0d00-4b96-ac7e-571dd1708518',
  'modern lush',
  'Blends modern structure with rich, dense planting. A limited palette and strong forms create rhythm and depth, achieving a lush, immersive feel without visual clutter.',
  'A Modern Lush garden blends the clean lines and structured aesthetic of modern design with rich, textural planting. While maintaining asymmetry and abstraction, this style embraces fullness—layering dense foliage and masses of plants to create a continuous visual rhythm. It incorporates restraint through a curated color palette and thoughtful repetition, achieving a lush, immersive effect without visual clutter. The result is a sophisticated, tactile space where structure meets abundance.',
  'linear, asymmetrical, informal hierarchy, odd spacing, abstraction, rhythm, massing, limited palette, full, textural, dense, continuous focal point'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '13bd400e-c849-4d28-b73e-54e7d1b7cc19',
  'classical',
  'Emphasizes symmetry, order, and geometry with manicured lawns, sculpted shrubs, and a restrained palette. Formal structure and repetition create timeless elegance.',
  'A Classical garden emphasizes structure, balance, and timeless elegance. Rooted in symmetry and formal hierarchy, this style features linear layouts, geometric planting patterns, and meticulously defined borders—often through evergreen hedges or hardscaping that remain present year-round. Gardens are typically curated around a formal path system that leads the eye toward focal points such as fountains, sculptures, or neatly clipped topiary. Plantings follow a limited color palette, typically favoring greens and whites, with repetition and order reinforcing a sense of calm and control. Manicured lawns, sculpted shrubs, and ornamental elements lend a sense of refinement and grandeur.',
  'geometrical, symmetrical, formal hierarchy, even spacing, order, repetition, massing, limited palette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  'ea911dc9-eb50-4809-bd8b-f1202cce3f17',
  'cottage',
  'A colorful, romantic garden filled with densely layered flowers and herbs. Informal and abundant, it blends ornament and utility with personal charm.',
  'While it shares the wild charm and informality of a naturalistic garden, the Cottage garden adds a distinctly romantic and curated flair. Overflowing with color, scent, and personality, this style mixes edible and ornamental plants in a dense, layered fashion that feels spontaneous but often reflects human intention. Cottage gardens typically favor traditional favorites—roses, herbs, and self-seeding perennials—arranged in a way that suggests abundance and lived-in comfort. Unlike naturalistic gardens, which aim to mimic native ecosystems, cottage gardens lean into nostalgic beauty and personal expression, with a looser relationship to ecological function.',
  'overflowing, layered, romantic, whimsical, nostalgic, informal, colorful, fragrant, cottagecore, natural'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  'abdda3fe-350a-471b-ab82-c4c2e38326de',
  'naturalistic',
  'A relaxed, organic garden inspired by native landscapes. Flowing plant groupings and natural materials create a vibrant, ever-changing space full of life and movement.',
  'A Naturalistic garden embraces the untamed beauty of nature, blurring the boundary between cultivated space and wild landscape. Inspired by native ecosystems—from sun-drenched prairies to shaded woodlands—this style prioritizes biodiversity, habitat creation, and ecological harmony. Plants are arranged in loose, organic patterns that mimic natural plant communities, with clumped or scattered groupings and no formal hierarchy. Materials like stone, wood, and gravel blend seamlessly into the environment, while color, texture, and form follow the rhythms of the surrounding landscape. Whether open and airy or densely layered, naturalistic gardens evolve with the seasons and invite both people and wildlife into a living, dynamic space.',
  'meandering, random, lack of hierarchy, no spacing rules, wild, scattered, clumped, large palette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '3908995b-a170-49ea-93ec-e01556056b16',
  'naturalistic woodland',
  'Shade-loving native plants arranged in soft layers under trees. Inspired by forest floors, it feels quiet, textured, and seasonal.',
  'Shaded and serene, the Woodland naturalistic garden draws inspiration from forest understories and dappled glades. Plantings emphasize shade-loving natives such as ferns, groundcovers, woodland grasses, and spring ephemerals, arranged in loose layers that follow the natural contours of the land. Trees and understory shrubs provide vertical structure, while mosses, leaf litter, and natural stone pathways create a grounded, organic feel. Designed to feel untouched and timeless, this garden thrives in full to partial shade and encourages seasonal shifts, from early spring blooms to the golden tones of fall.',
  'meandering, random, lack of hierarchy, no spacing rules, wild, scattered, clumped, large palette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '9f740bed-c308-4099-aed4-e42b7e042dd8',
  'naturalistic prairie',
  'Sun-loving grasses and wildflowers arranged in natural drifts. A dynamic, low-intervention garden full of movement, color, and habitat value.',
  'Expansive, sun-filled, and dynamic, the Prairie naturalistic garden mimics the beauty and resilience of native grasslands. Tall and short grasses—such as little bluestem or switchgrass—sway among vibrant wildflowers in irregular, intermingled groupings. Designed for full sun and open exposure, this style values movement, pollinator support, and long-season interest. Drifts of color, clumps of texture, and soft transitions between plants create a living tapestry that changes daily. Hardscaping is minimal, allowing the planting palette and the play of wind and light to take center stage.',
  'meandering, random, lack of hierarchy, no spacing rules, wild, scattered, clumped, large palette'
) ON CONFLICT (id) DO NOTHING;

-- Plants Inserts
INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'a852e93f-b0c2-4d15-98ea-fc96f55bc2b4',
  'prairie acacia',
  NULL,
  'acacia angustissima',
  'shrub',
  TRUE,
  'full-sun, part-shade',
  1,
  4,
  1.5,
  2,
  'spring, fall',
  NULL,
  'reddish_brown',
  NULL
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '0e7dddbb-ebdc-4e94-9450-f16a39da6828',
  'splitbeard bluestem',
  NULL,
  'andropogon ternarius',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2,
  4,
  0.5,
  1,
  'summer, fall, winter',
  NULL,
  'brown',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282045/cedar-sedge_hwoyoo.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'aade954c-da18-48c2-90da-5f77b45c9a07',
  'false boneset',
  'brickellbush',
  'brickellia eupatorioides',
  'herbaceous',
  FALSE,
  'full-sun, part-shade',
  3,
  4,
  1,
  2,
  'summer, fall',
  NULL,
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287878/brickelliacalifornica_hxewed.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '84a0b1e4-74f1-4102-a026-8ca5f4f35185',
  'cedar sedge',
  NULL,
  'carex planostachys',
  'grass & sedge',
  FALSE,
  'full-sun',
  0.5,
  4,
  1,
  1,
  'spring, summer',
  NULL,
  'green',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287880/carex_angustisquama_yamatanukirn04_ofai6o.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'c39f1378-ed04-46f2-82f8-eae235ccc6c7',
  'hairy sunflower',
  'rough sunflower',
  'helianthus hirsutus',
  'herbaceous',
  FALSE,
  'full-sun, part-shade, shade',
  3,
  6,
  2,
  3,
  'summer, fall',
  NULL,
  'yellow',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287882/hairy_sunflower__1020466042_hodmut.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '43dab1a9-0736-4331-84d6-6ad4859b6db2',
  'elephant ear',
  NULL,
  'colocasia esculenta',
  'herbaceous',
  TRUE,
  'full-sun, part-shade, full-shade',
  3,
  6,
  2,
  6,
  'summer, fall, winter',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282053/elephant-ear_nwvvue.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '238ecc8b-d8d5-4e96-9bb0-0fca3873ceaa',
  'foxtail fern',
  'asparagus fern',
  'asparagus aethiopicus',
  'herbaceous',
  TRUE,
  'part-shade',
  2,
  3,
  2,
  3,
  'summer, fall, winter',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287877/asparagus_densiflorus__myersii_oin8n7.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'af85ae84-5dbc-4c63-bfff-d756b5ce5583',
  'pink muhly grass',
  NULL,
  'muhlenbergia capillaris',
  'grass',
  FALSE,
  'full-sun, part-shade',
  2,
  3,
  2,
  3,
  'fall, winter',
  'grass_green',
  'deep_pink',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282058/pink-muhly-grass_z3sumw.webp'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '39b6475b-5dbe-407c-ac33-fc524b95ffb1',
  'boxwood',
  NULL,
  'buxus spp.',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2,
  15,
  2,
  4,
  NULL,
  'grass_green',
  NULL,
  'https://res.cloudinary.com/dprixcop0/image/upload/v1753128204/boxwood_gqpns0.webp'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '7220b937-11e6-4e9c-b9f9-82a5c96193bb',
  'hybrid tea roses',
  NULL,
  'rosa spp.',
  'shrub',
  FALSE,
  'full-sun',
  3,
  6,
  2,
  4,
  NULL,
  NULL,
  NULL,
  NULL
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '84a609b6-81c5-44b6-bac5-2403aa74df49',
  'lavender',
  NULL,
  'lavendula spp.',
  'shrub',
  FALSE,
  'full-sun',
  1,
  3,
  4,
  5,
  NULL,
  NULL,
  'purple',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282056/lavender_dc4pon.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '5a3b8fe3-af36-4f49-b424-48d8d93d8382',
  'hydrangeas',
  'big daddy',
  'hydrangea macrophylla',
  'shrub',
  TRUE,
  'full-sun, part-shade, full-shade',
  5,
  6,
  5,
  6,
  'spring, summer',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287885/hydrangea_macrophylla_-_bigleaf_hydrangea2_fjkn5c.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'bfbc7208-fe65-4781-a49e-b7356f4fb18e',
  'lambs ear',
  NULL,
  'stachys byzantina',
  'herbaceous',
  FALSE,
  'full-sun, part-shade',
  6,
  12,
  1,
  3,
  'spring, summer, fall',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282056/lambs-ear_daq1ds.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '37902125-8575-4bc2-9038-3a3834a122e9',
  'cat''s pajamas catmint',
  NULL,
  'epeta',
  'herbaceous',
  FALSE,
  'full-sun, part-shade',
  0.75,
  2,
  1,
  2,
  'spring, summer, fall',
  NULL,
  'sage_green',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287881/chasmanthium_latifolium_boyle_park_g8rpma.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'ed8dcc41-7e3c-4667-b277-0772edb26c59',
  'coneflowers',
  NULL,
  'centaurea cyanus',
  'herbaceous',
  FALSE,
  'full-sun',
  2,
  3,
  2,
  3,
  'spring, summer',
  NULL,
  'pink',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282048/copy_of_cone-flower_zqcl3s.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'fb74003c-b8d2-4008-a0af-d8f35e93cf80',
  'hakone grass',
  'aurelia',
  'hakonechloa macra',
  'grass',
  FALSE,
  'full-sun, part-shade, full-shade',
  1,
  2,
  1,
  2,
  'spring, summer, fall',
  NULL,
  'yellow',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282055/hakone-grass_inabds.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '97613806-d0d9-4f55-91d0-c8857d753ff3',
  'siberian bugloss',
  'jack frost',
  'brunnera macrophylla',
  'herbaceous',
  FALSE,
  'part-shade, full-shade',
  1,
  2,
  1,
  2,
  'spring, summer',
  NULL,
  'blue',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287881/brunnera-macrophhylla-1_xq83za.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '26977d0f-7571-4f0d-a77d-2c47dd0c2c7a',
  'hellebore',
  NULL,
  'helleborus x nigercors',
  'herbaceous',
  TRUE,
  'part-shade',
  1,
  2,
  1,
  2,
  'spring, winter',
  NULL,
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287885/helleborus_orientalis._lenteroos_04_c7xr2e.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'd505e982-8323-4fcc-a2c8-de09e2c4af35',
  'chinese silver grass',
  NULL,
  'miscanthus sinensis',
  'grass',
  FALSE,
  'full-sun, part-shade',
  3,
  8,
  3,
  5,
  'summer, fall, winter',
  'grass_green',
  'tan',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287886/japanese_pampas_grass_%e3%82%b9%e3%82%b9%e3%82%ad%e3%81%ae%e7%a9%82%e6%b3%a2pb080105_umyjuu.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '37dd5c45-2d44-4a6c-9867-3add8a20386f',
  'century plant',
  NULL,
  'agave americana',
  'succulent',
  TRUE,
  'full-sun',
  3,
  6,
  6,
  10,
  'spring, summer',
  'sage_green',
  'goldenrod',
  NULL
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'e5197b88-3050-4d73-a99e-da81c1700547',
  'inland sea oats',
  NULL,
  'chasmanthium latifolium',
  'grass',
  FALSE,
  'part-shade, full-shade',
  2,
  4,
  1,
  6,
  'fall',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287881/chasmanthium_latifolium_boyle_park_g8rpma.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '8f2e6bbb-9fdf-4cdb-ad41-fa69bfdcd0ac',
  'lavender cotton',
  NULL,
  'santolina chamaecyparissus',
  'shrub',
  TRUE,
  'full-sun, part-shade',
  1,
  2,
  2,
  3,
  'spring, summer, fall',
  NULL,
  'silver_gray',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287878/astilbe_rubra_kz2_ijxkt0.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '8d8304a6-6cb3-4a9a-9276-76488891cdcf',
  'japanese painted fern',
  NULL,
  'athyrium niponicum var. pictum',
  'herbaceous',
  TRUE,
  'part-shade, full-shade',
  1,
  1.5,
  1,
  1.5,
  'spring, summer',
  'purple_brown',
  'pale_green',
  'https://res.cloudinary.com/dprixcop0/image/upload/v1753127972/japanese-painted-fern_tioauz.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'c07ec418-1cc2-4491-8e3b-a76ba437f19d',
  'hosta ''formal attire''',
  NULL,
  'plantain lilies',
  'shrub',
  TRUE,
  'part-shade, full-shade',
  1.5,
  2.5,
  2,
  2.5,
  'spring, summer',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287885/hosta_plantaginea_cv_royal_standard_1_wjby1o.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '94c4903a-a756-4059-8cb2-d632a5e85e97',
  'astilbe',
  NULL,
  'astilbe',
  'herbaceous',
  FALSE,
  'full-sun, part-shade, full-shade',
  1.5,
  6,
  1.5,
  6,
  'spring, summer',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287878/astilbe_rubra_kz2_ijxkt0.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'fd6b0991-b429-43c7-8b3d-2a648f4daf92',
  'heuchera ''bella notte''',
  'coral bells, bella notte',
  'bella notte',
  'shrub',
  FALSE,
  'part-shade, full-shade',
  0.75,
  1,
  1,
  1.25,
  'summer, fall',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287889/san_gabriel_mountains_coralbells_wmtf7w.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '70627b83-8d67-4602-b0a3-d48c6a60f64a',
  'foamflower',
  NULL,
  'tiarella cordifolia',
  'herbaceous',
  FALSE,
  'part-shade, full-shade',
  0.5,
  1,
  1,
  2,
  'summer',
  'lime_green',
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282055/foamflower_hw5oc7.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '20f2afe3-9d52-4807-a18f-a23158f04215',
  'spreading plum yew',
  'spreading japanese plum yew',
  'cephalotaxus harringtonia ''prostrata''',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2,
  3,
  3,
  4,
  'summer, fall',
  'lime_green',
  NULL,
  'https://res.cloudinary.com/dprixcop0/image/upload/v1753127016/spreading-japanese-plum-yew_c7753v.webp'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f683c515-e1d2-406f-bb3d-82c3147c0fe9',
  'anacacho orchid tree',
  NULL,
  'bauhinia lunarioides',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  6,
  12,
  3,
  6,
  'spring',
  'sage_green',
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282044/anacacho-orchid-tree_fw1xpf.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '26b55457-8e9e-4e77-882c-09e9d8307b91',
  'teresa''s texas sage',
  NULL,
  'salvia greggii ''teresa''',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2.5,
  3,
  2.5,
  3,
  'spring, summer',
  'grass_green',
  'baby_lavender',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282058/teresas-texas-sage_evcdgc.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '15eb72a4-ef0e-4e93-b04c-41b2f608c650',
  'blackfoot daisy',
  NULL,
  'melampodium leucanthum',
  'herbaceous',
  FALSE,
  'full-sun, part-shade',
  0.5,
  1,
  1,
  2,
  'spring, summer, fall',
  'grass_green',
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282046/copy_of_anacacho-orchid-tree_vovrrs.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '550d1b56-81bb-4e80-94f0-66fd9d0c7127',
  'flame acanthus',
  NULL,
  'anisacanthus quadrifidus',
  'shrub',
  FALSE,
  'full-sun, part-shade, full-shade',
  3,
  5,
  2,
  4,
  'summer, fall',
  'lime_green',
  'red_orange',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282054/flame-acanthus_e0ci4n.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'e88f8339-d195-4bf8-ab44-0237f0f55f44',
  'mealy blue sage',
  NULL,
  'salvia farinacea',
  'shrub',
  FALSE,
  'full-sun',
  2,
  3,
  3,
  3,
  'spring, summer, fall',
  'sage_green',
  'lavender',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282056/mealy-blue-sage_ixgfxa.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '964ca2f2-5e5e-498e-bbaf-90ce9a2ba228',
  'texas sotol',
  NULL,
  'dasylirion texanum',
  'shrub',
  FALSE,
  'full-sun',
  1.5,
  2.5,
  1.5,
  2.5,
  'summer',
  'grass_green',
  'yellow',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282059/texas-sotol_qaxtys.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'd0fdc076-8b92-46b1-a65d-b919dec14029',
  'white autumn sage',
  NULL,
  'salvia greggii ‘white’',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2,
  3,
  2,
  3,
  'spring, summer',
  'grass_green',
  'baby_lavender',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282059/white-autumn-sage_ekfmqt.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '738d015d-5f93-4000-a926-476f0b7a31a3',
  'mexican feathergrass',
  NULL,
  'nassella tenuissima',
  'grass',
  FALSE,
  'full-sun, part-shade',
  1,
  3,
  1,
  3,
  'summer',
  'pale_green',
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282056/mexican-feathergrass_tdsafo.jpg'
) ON CONFLICT (id) DO NOTHING;

-- plant_Design_Types Inserts
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e25daafe-721f-4d5e-85a8-020de5a5557c', 'a852e93f-b0c2-4d15-98ea-fc96f55bc2b4', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('914418dc-7211-47e9-8486-e8f7e3ea2f9f', 'a852e93f-b0c2-4d15-98ea-fc96f55bc2b4', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b5f58ff6-4f0c-4e67-8f5e-94892670687e', 'a852e93f-b0c2-4d15-98ea-fc96f55bc2b4', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('943772c1-eb7e-4f6f-a714-4c76078636db', 'a852e93f-b0c2-4d15-98ea-fc96f55bc2b4', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c4e90249-5f2a-4e9a-9acb-b4252fca328f', '0e7dddbb-ebdc-4e94-9450-f16a39da6828', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('831e69f1-c877-4e5f-90db-a7cb7a67637f', '0e7dddbb-ebdc-4e94-9450-f16a39da6828', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d5b59653-efb5-4832-9554-67802516d31d', '0e7dddbb-ebdc-4e94-9450-f16a39da6828', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9b52c34f-b669-4299-968b-58b7350e07eb', '0e7dddbb-ebdc-4e94-9450-f16a39da6828', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f1e2af73-1263-440b-8cd5-bef21ef591b8', '0e7dddbb-ebdc-4e94-9450-f16a39da6828', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e29117b5-765d-4e79-a48a-699b801de42e', 'aade954c-da18-48c2-90da-5f77b45c9a07', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('540c6f48-08e3-4ef5-8115-57a53e747349', 'aade954c-da18-48c2-90da-5f77b45c9a07', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('991871a4-9b79-4f5e-ada8-38b061afaf3f', '84a0b1e4-74f1-4102-a026-8ca5f4f35185', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0ebe48ec-3eb0-4eef-a3e0-5cbb648cee01', '84a0b1e4-74f1-4102-a026-8ca5f4f35185', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2d8c09a9-b89d-40ac-ac0d-537ffd606952', '84a0b1e4-74f1-4102-a026-8ca5f4f35185', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0b5aed3d-95ef-46f2-a48d-a58fc6ec133c', '84a0b1e4-74f1-4102-a026-8ca5f4f35185', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4cb032f7-fdb9-434e-bb7d-656f4b122cd4', 'c39f1378-ed04-46f2-82f8-eae235ccc6c7', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6d2e7fe6-a2d0-4e95-a273-bb40f168b15a', 'c39f1378-ed04-46f2-82f8-eae235ccc6c7', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e4d14090-4155-4861-a3cb-9616d051e0f5', '43dab1a9-0736-4331-84d6-6ad4859b6db2', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('06dbe5f2-1ebb-47e9-99a0-d9de0bfc4f65', '43dab1a9-0736-4331-84d6-6ad4859b6db2', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('57209637-0b93-4400-b5cb-0383dca89b93', '43dab1a9-0736-4331-84d6-6ad4859b6db2', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8ae409d6-21db-41d9-8aea-3f8f592c84b9', '43dab1a9-0736-4331-84d6-6ad4859b6db2', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a233751f-b3d3-4a1c-8b97-adf92c61e99f', '238ecc8b-d8d5-4e96-9bb0-0fca3873ceaa', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('319d1a74-e1e6-4b83-a356-73dfa301d04c', '238ecc8b-d8d5-4e96-9bb0-0fca3873ceaa', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d8fb4e04-f2cf-487f-a56a-3a07a3b1167f', '238ecc8b-d8d5-4e96-9bb0-0fca3873ceaa', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('af5908d5-40be-45d4-b416-086a162952a0', '238ecc8b-d8d5-4e96-9bb0-0fca3873ceaa', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('aab8dccd-af79-4b3e-b2ba-b5b9c9be7a0d', 'af85ae84-5dbc-4c63-bfff-d756b5ce5583', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('06f7670c-62b8-4f71-907a-fae7292bab0d', 'af85ae84-5dbc-4c63-bfff-d756b5ce5583', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b4834683-754e-4b1c-b899-aebb4ce21c8c', 'af85ae84-5dbc-4c63-bfff-d756b5ce5583', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1a4e028c-946c-42e7-9e8b-3ca90b98ca88', 'af85ae84-5dbc-4c63-bfff-d756b5ce5583', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f2f6a8b6-ebb0-472e-90e5-33bdb8f3f287', 'af85ae84-5dbc-4c63-bfff-d756b5ce5583', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7c39a215-0a42-4659-996e-25d85118328c', '39b6475b-5dbe-407c-ac33-fc524b95ffb1', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7b8918fe-1f9a-4544-907e-110774d08dbb', '39b6475b-5dbe-407c-ac33-fc524b95ffb1', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4b851683-f78f-472e-b097-233b3f9137c0', '39b6475b-5dbe-407c-ac33-fc524b95ffb1', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('aaff1847-4b9a-4883-aefa-22b74ac471a2', '7220b937-11e6-4e9c-b9f9-82a5c96193bb', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2f9637fc-c74b-48b7-a39c-b05816973dd7', '84a609b6-81c5-44b6-bac5-2403aa74df49', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1b55cb77-6cbd-40cc-a3f7-86d992da2f10', '84a609b6-81c5-44b6-bac5-2403aa74df49', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('81891352-a578-4de6-ab5b-2f5e6c6af8be', '84a609b6-81c5-44b6-bac5-2403aa74df49', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d9c215b3-e3a2-43c5-b73e-b548d7b7e1dd', '84a609b6-81c5-44b6-bac5-2403aa74df49', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e285b25d-3e7c-4e86-93d3-157b8522cc99', '84a609b6-81c5-44b6-bac5-2403aa74df49', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3fd22e9b-8258-4932-9f69-54b099d19838', '5a3b8fe3-af36-4f49-b424-48d8d93d8382', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('89ad1c99-f7c0-4588-a7e9-b07bfa8d6aa5', '5a3b8fe3-af36-4f49-b424-48d8d93d8382', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f8218656-90c4-4812-8b02-286c20379fb4', '5a3b8fe3-af36-4f49-b424-48d8d93d8382', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1ec9ff9b-70ad-4cdf-a44a-489dcfa58804', 'bfbc7208-fe65-4781-a49e-b7356f4fb18e', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('aa85865a-004a-4590-988d-0f1f6db1cf41', 'bfbc7208-fe65-4781-a49e-b7356f4fb18e', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('48e4b7e7-faea-4877-825a-01077173d1c3', 'bfbc7208-fe65-4781-a49e-b7356f4fb18e', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8b588687-5093-4dd3-a67a-cfa84ec0c82f', 'bfbc7208-fe65-4781-a49e-b7356f4fb18e', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('54a24beb-bdd5-4452-8c6a-86e5b9355356', 'bfbc7208-fe65-4781-a49e-b7356f4fb18e', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('95b764b0-2dfa-44d3-8e0f-1a177b8586ce', '37902125-8575-4bc2-9038-3a3834a122e9', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d70cff4b-359d-4a33-a937-390ea5ed9bda', '37902125-8575-4bc2-9038-3a3834a122e9', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('658744bd-e48a-434b-aeab-373b17bfe278', '37902125-8575-4bc2-9038-3a3834a122e9', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('75584a92-fda8-41d2-8da8-fb148dfa224d', '37902125-8575-4bc2-9038-3a3834a122e9', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a84d3fbc-8780-49cc-9176-db78bd896578', '37902125-8575-4bc2-9038-3a3834a122e9', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('dd9e6064-5055-417d-9685-2618d2026471', 'ed8dcc41-7e3c-4667-b277-0772edb26c59', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('65266b4d-62e1-4116-a994-e94ae0d35731', 'ed8dcc41-7e3c-4667-b277-0772edb26c59', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f8188bb2-7b30-4829-a9fd-35475d783b7d', 'ed8dcc41-7e3c-4667-b277-0772edb26c59', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('07577151-5604-45aa-9adb-a3f1169e0a00', 'ed8dcc41-7e3c-4667-b277-0772edb26c59', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('39c2334d-a75c-4272-95e9-35029643face', 'fb74003c-b8d2-4008-a0af-d8f35e93cf80', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('48205a57-00c7-4c5f-9d80-82c6a79898fa', 'fb74003c-b8d2-4008-a0af-d8f35e93cf80', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b9a0e52e-92b2-4881-9c71-c6caafb811d6', 'fb74003c-b8d2-4008-a0af-d8f35e93cf80', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('cb6375a7-a125-43b6-894a-541695be431e', 'fb74003c-b8d2-4008-a0af-d8f35e93cf80', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('565b3227-06a1-4498-8f02-9c3b584a73ca', 'fb74003c-b8d2-4008-a0af-d8f35e93cf80', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e72ccc16-e39a-435e-91ed-e9e5167971bb', '97613806-d0d9-4f55-91d0-c8857d753ff3', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0bb741fd-a2e3-4d3a-a689-6ed1abe8a067', '97613806-d0d9-4f55-91d0-c8857d753ff3', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a72a72ea-29da-4657-863c-61965aca8107', '97613806-d0d9-4f55-91d0-c8857d753ff3', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7ee0495b-c7c7-4c8c-b134-ef47678428b7', '26977d0f-7571-4f0d-a77d-2c47dd0c2c7a', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('08cf24b8-552b-4196-a842-380f10a8e4f7', '26977d0f-7571-4f0d-a77d-2c47dd0c2c7a', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1b45e39f-aa28-4eba-a7ae-4268f4236d52', '26977d0f-7571-4f0d-a77d-2c47dd0c2c7a', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8c6ed17b-4f5b-4666-a79a-c73ef472afe3', 'd505e982-8323-4fcc-a2c8-de09e2c4af35', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9bebc84b-53d4-4fa6-ab8d-2fdbb1a5a112', 'd505e982-8323-4fcc-a2c8-de09e2c4af35', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('59d72135-293f-43a4-ada3-9c13d58645f8', 'd505e982-8323-4fcc-a2c8-de09e2c4af35', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1d41c752-4cb4-41e8-95a8-d1c36ede322b', 'd505e982-8323-4fcc-a2c8-de09e2c4af35', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ee0f9263-91f9-4173-89f4-ab1a3f2af525', 'd505e982-8323-4fcc-a2c8-de09e2c4af35', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2d16ca36-d6b9-4c7c-bee6-1746400ab51b', '37dd5c45-2d44-4a6c-9867-3add8a20386f', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ba1a5bf2-8b21-4b2c-a85a-8d7f37136327', '37dd5c45-2d44-4a6c-9867-3add8a20386f', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('66cc2234-ee17-4a31-9922-6a73c2286060', '37dd5c45-2d44-4a6c-9867-3add8a20386f', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('db02f87e-8819-4903-8d89-1fa7941f384f', 'e5197b88-3050-4d73-a99e-da81c1700547', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7417a823-bbb6-49f4-ae82-0e2475e35c82', 'e5197b88-3050-4d73-a99e-da81c1700547', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d75abed4-35d0-4775-8432-3212a38b4bb8', 'e5197b88-3050-4d73-a99e-da81c1700547', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0956b247-2495-4214-a124-41a2104e533c', 'e5197b88-3050-4d73-a99e-da81c1700547', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4789ff6c-e19e-426e-a132-d49e0657fffb', 'e5197b88-3050-4d73-a99e-da81c1700547', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('172e7989-b103-44c6-9aef-e8ab44f0a4e0', '8f2e6bbb-9fdf-4cdb-ad41-fa69bfdcd0ac', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('011a39bd-5052-4f74-ae64-6a91e82360de', '8f2e6bbb-9fdf-4cdb-ad41-fa69bfdcd0ac', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fb4d90e8-5700-4d19-bee9-dedda563a584', '8f2e6bbb-9fdf-4cdb-ad41-fa69bfdcd0ac', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('447d4b16-4064-4655-a5fb-5cc3d5d05738', '8f2e6bbb-9fdf-4cdb-ad41-fa69bfdcd0ac', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('87bef11c-9165-442b-b8a7-622b148e77cd', '8d8304a6-6cb3-4a9a-9276-76488891cdcf', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d9c4c3da-6c6b-4f78-900b-dff32b1b0853', '8d8304a6-6cb3-4a9a-9276-76488891cdcf', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('85a08842-b64a-4b9b-98cf-f7da957ff2af', '8d8304a6-6cb3-4a9a-9276-76488891cdcf', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('40c4d917-1bbb-4d62-96aa-206b7e19292c', '8d8304a6-6cb3-4a9a-9276-76488891cdcf', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('75b8fdde-2e89-4fe8-b70e-ed4d3e64dc8d', '8d8304a6-6cb3-4a9a-9276-76488891cdcf', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c4907ea5-c35f-411e-bba2-3180cce9b251', 'c07ec418-1cc2-4491-8e3b-a76ba437f19d', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2f2d5674-4820-4788-8611-aec1d32a024c', 'c07ec418-1cc2-4491-8e3b-a76ba437f19d', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2af48529-ad2d-4e02-929f-3d89cd5393a7', 'c07ec418-1cc2-4491-8e3b-a76ba437f19d', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6796e02e-fd1b-4116-b2d9-1263850bb10a', '94c4903a-a756-4059-8cb2-d632a5e85e97', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('25389e97-7e19-4984-ae88-c0d66dfa155d', '94c4903a-a756-4059-8cb2-d632a5e85e97', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('08049ad5-0e5f-4185-b179-76ade9996299', '94c4903a-a756-4059-8cb2-d632a5e85e97', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a19a6ca8-f7bf-4fb2-b308-3623ce940358', '94c4903a-a756-4059-8cb2-d632a5e85e97', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e8968baa-c67d-41b4-8514-a2be38a2f532', '94c4903a-a756-4059-8cb2-d632a5e85e97', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8b864349-4edc-40c1-a907-74cc1184a4d5', 'fd6b0991-b429-43c7-8b3d-2a648f4daf92', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('45c16982-bf51-4fa6-93f7-9bf4d04d9d17', 'fd6b0991-b429-43c7-8b3d-2a648f4daf92', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ca8d9760-f859-48f0-ad83-34b98dd0c314', 'fd6b0991-b429-43c7-8b3d-2a648f4daf92', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4bd8b0b6-2a1f-4bbd-bec8-a6c46117bcbe', '70627b83-8d67-4602-b0a3-d48c6a60f64a', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('de1592b3-3625-4d87-b948-addf20b48736', '70627b83-8d67-4602-b0a3-d48c6a60f64a', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('de20110d-ec0b-4a1e-b6bd-d218aa0866cc', '70627b83-8d67-4602-b0a3-d48c6a60f64a', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('59380d6d-8b40-4ef6-b0cc-29a2ee32672f', '20f2afe3-9d52-4807-a18f-a23158f04215', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b8102674-2ca6-4b7a-b0e0-8fce5ea9a2b3', '20f2afe3-9d52-4807-a18f-a23158f04215', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a3f11342-2613-4cd4-ab2f-0597aa9f04ea', '20f2afe3-9d52-4807-a18f-a23158f04215', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('43c2eadb-6dd2-4037-be28-bf083b51582d', '20f2afe3-9d52-4807-a18f-a23158f04215', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('96262f87-3f85-4def-90bb-75bf8adf611d', '20f2afe3-9d52-4807-a18f-a23158f04215', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1be3d5c5-af2c-4aca-b9ea-acf82b592d8e', 'f683c515-e1d2-406f-bb3d-82c3147c0fe9', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('861f3bf5-3dfb-41aa-9cc0-c316b7d5d4e5', 'f683c515-e1d2-406f-bb3d-82c3147c0fe9', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ce5343e4-ecc3-4bf8-a7c5-48003e48daa1', 'f683c515-e1d2-406f-bb3d-82c3147c0fe9', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b6c602eb-6d90-4ea5-90e9-0c3f80339cd2', 'f683c515-e1d2-406f-bb3d-82c3147c0fe9', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('15ffab2d-8316-447c-b59f-acd5c0d45986', 'f683c515-e1d2-406f-bb3d-82c3147c0fe9', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3f2b8cd3-3fb0-403a-b590-43faf26fd429', '26b55457-8e9e-4e77-882c-09e9d8307b91', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b9535940-4e70-4679-884f-c5338050c374', '26b55457-8e9e-4e77-882c-09e9d8307b91', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ab97168a-98f7-45f1-bd9b-75e0f0cef966', '26b55457-8e9e-4e77-882c-09e9d8307b91', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('94914b28-4724-44e6-9c2f-ee2d839ed1a1', '26b55457-8e9e-4e77-882c-09e9d8307b91', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a9e4b297-4b54-42fd-8fa4-69c0f4f2941e', '26b55457-8e9e-4e77-882c-09e9d8307b91', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('273f13ef-4047-4609-88fe-21e81b6a21df', '15eb72a4-ef0e-4e93-b04c-41b2f608c650', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bf50ea1b-94b6-40e2-86a1-52fa35cc6dcb', '15eb72a4-ef0e-4e93-b04c-41b2f608c650', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b97cb6cb-cf20-4c03-ac10-f6d560884fb0', '15eb72a4-ef0e-4e93-b04c-41b2f608c650', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6b9462b9-1d1d-476c-aac4-6489b49c3f47', '550d1b56-81bb-4e80-94f0-66fd9d0c7127', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e4217692-e086-4692-b3b3-70cf6da58c74', '550d1b56-81bb-4e80-94f0-66fd9d0c7127', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('70b17ac4-981a-4d49-9720-40042406ada6', '550d1b56-81bb-4e80-94f0-66fd9d0c7127', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a15e8885-fea6-4f48-8c0a-31710e3f5ec7', '550d1b56-81bb-4e80-94f0-66fd9d0c7127', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d52239e6-9d23-49e8-8aff-d8abd6793a34', '550d1b56-81bb-4e80-94f0-66fd9d0c7127', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bf7a3e09-baeb-46ad-b484-0ac400b9a58d', 'e88f8339-d195-4bf8-ab44-0237f0f55f44', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1df4b1c0-948a-480e-8606-06d67eaebc05', 'e88f8339-d195-4bf8-ab44-0237f0f55f44', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c8da83ff-064d-4c13-aae4-d64f7ebebfe0', 'e88f8339-d195-4bf8-ab44-0237f0f55f44', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('da6918d6-ed2b-4a68-b3b6-7e033c9323d6', '964ca2f2-5e5e-498e-bbaf-90ce9a2ba228', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6fcf0838-ce43-4a93-8c66-1e1eec1bce08', '964ca2f2-5e5e-498e-bbaf-90ce9a2ba228', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0ea735a7-12c4-42ad-89c7-88ff5bac54ba', '964ca2f2-5e5e-498e-bbaf-90ce9a2ba228', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0d1687a6-a48e-4f3a-8418-0489dfb12c82', '964ca2f2-5e5e-498e-bbaf-90ce9a2ba228', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fc41bae2-c370-4825-988c-688cf370f104', 'd0fdc076-8b92-46b1-a65d-b919dec14029', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('85bd2962-048a-47dc-879c-fcbe317e6c41', 'd0fdc076-8b92-46b1-a65d-b919dec14029', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0a607aed-1ea6-4959-9791-e2f501f4a7e4', 'd0fdc076-8b92-46b1-a65d-b919dec14029', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bae0d4af-b8b1-48d5-941f-39390808b702', 'd0fdc076-8b92-46b1-a65d-b919dec14029', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d52a7104-ac7c-4c61-a7c3-66ab3b175402', 'd0fdc076-8b92-46b1-a65d-b919dec14029', '13bd400e-c849-4d28-b73e-54e7d1b7cc19') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e054c84a-483b-4363-8d76-fb3ff67a8bd7', '738d015d-5f93-4000-a926-476f0b7a31a3', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5705e546-ce4a-493a-a9a2-061862b273ad', '738d015d-5f93-4000-a926-476f0b7a31a3', 'ea3e1e8e-0d00-4b96-ac7e-571dd1708518') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('323396f2-5d89-4601-9a63-3b060322b799', '738d015d-5f93-4000-a926-476f0b7a31a3', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9409db8c-1e82-4451-a0b4-4ce1e688d65b', '738d015d-5f93-4000-a926-476f0b7a31a3', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (plant_id, design_id) DO NOTHING;

-- Projects Inserts
INSERT INTO projects (id, project_name, user_id) VALUES ('d4578d62-99bf-4b7c-843c-8d0cb5dfb480', 'BackyardForest', '22575560-a367-42e3-9bf0-49a5a7c8ddbc') ON CONFLICT (id) DO NOTHING;

-- Layouts Inserts
INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id) VALUES (
  '6ff0afb9-489f-4431-b080-e6da74b28fb6',
  'newBeginnings',
  10,
  10,
  'ea911dc9-eb50-4809-bd8b-f1202cce3f17',
  'd4578d62-99bf-4b7c-843c-8d0cb5dfb480'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id) VALUES (
  '2b96acc8-5555-43ac-88b9-59338e7b0476',
  'FernForest',
  12,
  6,
  '213f3124-3729-4bae-af4f-43b720e6b5df',
  'd4578d62-99bf-4b7c-843c-8d0cb5dfb480'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id) VALUES (
  '66a3e2f7-39e6-4685-8a86-f380d5d238ec',
  'AbsoluteSucculent',
  15,
  10,
  'abdda3fe-350a-471b-ab82-c4c2e38326de',
  'd4578d62-99bf-4b7c-843c-8d0cb5dfb480'
) ON CONFLICT (id) DO NOTHING;


-- Favorite Plants Inserts
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('2fe8be3d-1d36-472c-8a90-19f4f22e5199', '22575560-a367-42e3-9bf0-49a5a7c8ddbc', '8d8304a6-6cb3-4a9a-9276-76488891cdcf') ON CONFLICT (user_id, plant_id) DO NOTHING;
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('160f994b-0a2d-477f-8540-bc8a6f2c3061', '3b982c64-4293-48e3-a9cb-bc98e0df3e5b', '20f2afe3-9d52-4807-a18f-a23158f04215') ON CONFLICT (user_id, plant_id) DO NOTHING;
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('091b5180-0549-49ab-b9e5-1463ac2e5f05', '210954a1-1d49-4fec-a81f-92738276115f', '39b6475b-5dbe-407c-ac33-fc524b95ffb1') ON CONFLICT (user_id, plant_id) DO NOTHING;
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('dc27b06c-66d0-43f6-8b47-428fa537fae8', '069ea174-5ecb-4703-85c2-49c7286d93bc', '20f2afe3-9d52-4807-a18f-a23158f04215') ON CONFLICT (user_id, plant_id) DO NOTHING;

-- Plant Layout Inserts
INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height) VALUES (
  '8c2cd4b4-bf85-47d1-b611-6d415051ae20',
  '8d8304a6-6cb3-4a9a-9276-76488891cdcf',
  '6ff0afb9-489f-4431-b080-e6da74b28fb6',
  2,
  3,
  1.00,
  1.00
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height) VALUES (
  '3d79bc8f-2295-4251-9e9c-d013877e98cb',
  '20f2afe3-9d52-4807-a18f-a23158f04215',
  '2b96acc8-5555-43ac-88b9-59338e7b0476',
  15,
  7,
  3.00,
  2.00
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height) VALUES (
  '00e72c90-2dea-4fe4-bac0-1635bc5a160e',
  '39b6475b-5dbe-407c-ac33-fc524b95ffb1',
  '66a3e2f7-39e6-4685-8a86-f380d5d238ec',
  10,
  5,
  2.00,
  2.00
) ON CONFLICT (id) DO NOTHING;


-- Fave Designs Inserts
INSERT INTO fave_design (id, user_id, design_id) VALUES ('242af303-f96c-471f-9cb9-5116f86cf118', '3b982c64-4293-48e3-a9cb-bc98e0df3e5b', '213f3124-3729-4bae-af4f-43b720e6b5df') ON CONFLICT (id) DO NOTHING;
INSERT INTO fave_design (id, user_id, design_id) VALUES ('4e4aeff4-974b-4f48-a505-d0baf156af44', '210954a1-1d49-4fec-a81f-92738276115f', 'abdda3fe-350a-471b-ab82-c4c2e38326de') ON CONFLICT (id) DO NOTHING;
INSERT INTO fave_design (id, user_id, design_id) VALUES ('1b168c08-26ba-4c08-ad2a-3989f9f73e63', '069ea174-5ecb-4703-85c2-49c7286d93bc', 'ea911dc9-eb50-4809-bd8b-f1202cce3f17') ON CONFLICT (id) DO NOTHING;

