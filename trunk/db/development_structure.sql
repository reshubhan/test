CREATE TABLE `asset_attribute_managers` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `manager_id` varchar(255) NOT NULL,
  `asset_attribute_id` int(11) NOT NULL,
  `votes` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_asset_attribute_managers_on_id` (`id`),
  KEY `index_asset_attribute_managers_on_user_id` (`user_id`),
  KEY `index_asset_attribute_managers_on_asset_attribute_id` (`asset_attribute_id`),
  KEY `index_asset_attribute_managers_on_manager_id` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `asset_attributes` (
  `id` int(11) NOT NULL auto_increment,
  `asset_id` int(11) default NULL,
  `attribute_id` int(11) default NULL,
  `attribute_type` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_asset_attributes_on_id` (`id`),
  KEY `index_asset_attributes_on_asset_id` (`asset_id`),
  KEY `index_asset_attributes_on_attribute_id` (`attribute_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `updated_by` int(11) default NULL,
  `created_by` int(11) default NULL,
  `parent_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_assets_on_id` (`id`),
  KEY `index_assets_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `assets_companies` (
  `asset_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `assets_funds` (
  `asset_id` int(11) NOT NULL,
  `fund_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `assets_managers` (
  `id` int(11) NOT NULL auto_increment,
  `asset_id` int(11) default NULL,
  `manager_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_assets_managers_on_id` (`id`),
  KEY `index_assets_managers_on_asset_id` (`asset_id`),
  KEY `index_assets_managers_on_manager_id` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `attributes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `updated_by` int(11) default NULL,
  `created_by` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_attributes_on_id` (`id`),
  KEY `index_attributes_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `classified_funds` (
  `id` int(11) NOT NULL auto_increment,
  `classified_fund_type` varchar(255) default NULL,
  `manager_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `approver_id` int(11) default NULL,
  `approved_at` datetime default NULL,
  `status` varchar(255) default 'approved',
  `description` text,
  `created_by` int(11) default NULL,
  `updated_by` int(11) default NULL,
  `desired_size` varchar(255) default NULL,
  `position` varchar(255) default NULL,
  `fund_size` varchar(255) default NULL,
  `geography_id` int(11) default NULL,
  `asset_id` int(11) default NULL,
  `asset_type_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `fund_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `classified_funds_funds` (
  `fund_id` int(11) NOT NULL,
  `classified_fund_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `classified_funds_sectors` (
  `sector_id` int(11) NOT NULL,
  `classified_fund_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `comment_ratings` (
  `id` int(11) NOT NULL auto_increment,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rate` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL auto_increment,
  `body` varchar(400) NOT NULL,
  `user_id` int(11) default NULL,
  `manager_id` int(11) default NULL,
  `flag` tinyint(1) default '0',
  `relationship` varchar(255) default NULL,
  `experience_level` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `status` varchar(255) default 'approved',
  `parent_id` int(11) default NULL,
  `title` varchar(255) NOT NULL default 'New Commment',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_comments_on_id` (`id`),
  KEY `index_comments_on_manager_id` (`manager_id`),
  KEY `index_comments_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `companies` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `company_type` varchar(255) default NULL,
  `revenue_per_year` float default NULL,
  `currency` int(11) default NULL,
  `new_financing` tinyint(1) default NULL,
  `desired_size` varchar(255) default NULL,
  `geography_id` int(11) default NULL,
  `type_of_financing` varchar(255) default NULL,
  `posted_by` varchar(255) default NULL,
  `description` text,
  `asset_id` int(11) default NULL,
  `status` varchar(255) default 'approved',
  `user_id` int(11) default NULL,
  `updated_by` int(11) default NULL,
  `created_by` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `asset_type_id` int(11) default NULL,
  `featured` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `companies_sectors` (
  `sector_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `currencies` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `funds` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `size` float NOT NULL default '0',
  `year` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `approver_id` int(11) default NULL,
  `approved_at` datetime default NULL,
  `status` varchar(255) default 'approved',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `overview` varchar(255) default NULL,
  `portfolio` varchar(255) default NULL,
  `in_market` tinyint(1) default '0',
  `updated_by` int(11) default NULL,
  `created_by` int(11) default NULL,
  `fund_type` varchar(255) default NULL,
  `currency` int(11) default NULL,
  `investors` varchar(255) default NULL,
  `irr` float default NULL,
  `multiple` float default NULL,
  `seller_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_funds_on_id` (`id`),
  KEY `index_funds_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `funds_sectors` (
  `fund_id` int(11) NOT NULL,
  `sector_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `geographies` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `created_by` int(11) default NULL,
  `updated_by` int(11) default NULL,
  `created_at` int(11) default NULL,
  `updated_at` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_geographies_on_id` (`id`),
  KEY `index_geographies_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `logs` (
  `id` int(11) NOT NULL auto_increment,
  `action` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `managers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `geography_id` int(11) NOT NULL,
  `asset_primary_id` int(11) NOT NULL,
  `asset_secondary_id` int(11) default NULL,
  `user_id` int(11) NOT NULL,
  `approver_id` int(11) default NULL,
  `approved_at` datetime default NULL,
  `status` varchar(255) default 'approved',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `description` varchar(700) default NULL,
  `geography_sub` varchar(255) default NULL,
  `image_remote_url` varchar(255) default NULL,
  `image` varchar(255) default NULL,
  `image_file_name` varchar(255) default NULL,
  `image_content_type` varchar(255) default NULL,
  `image_file_size` int(11) default NULL,
  `image_updated_at` datetime default NULL,
  `updated_by` int(11) default NULL,
  `created_by` int(11) default NULL,
  `new_name` varchar(255) default NULL,
  `new_url` varchar(255) default NULL,
  `featured` tinyint(1) default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_managers_on_id` (`id`),
  KEY `index_managers_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL auto_increment,
  `subject` varchar(255) default NULL,
  `body` text,
  `user_id` int(11) default NULL,
  `manager_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `order_transactions` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) default NULL,
  `action` varchar(255) default NULL,
  `amount` int(11) default NULL,
  `success` tinyint(1) default NULL,
  `authorization` varchar(255) default NULL,
  `message` varchar(255) default NULL,
  `params` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `plan_id` int(11) default NULL,
  `amount` int(11) default NULL,
  `card_type` varchar(255) default NULL,
  `card_expires_on` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `ip_address` varchar(255) default NULL,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `order_type` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) default NULL,
  `content` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `persons` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `approver_id` int(11) default NULL,
  `approved_at` datetime default NULL,
  `status` varchar(255) default 'approved',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `plans` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `fee` int(11) default NULL,
  `duration` varchar(255) default NULL,
  `subscription_type` varchar(255) default NULL,
  `role_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `discount` int(11) default NULL,
  `rank` int(11) default NULL,
  `no_of_views` int(11) default NULL,
  `no_of_emails` int(11) default NULL,
  `post_secondaries_to_buy` tinyint(1) default '1',
  `post_secondaries_to_sell` tinyint(1) default '1',
  `no_of_replies` int(11) default NULL,
  `no_of_credits` int(11) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL auto_increment,
  `firstname` varchar(40) NOT NULL,
  `lastname` varchar(40) NOT NULL,
  `job_title` varchar(100) default NULL,
  `email` varchar(255) NOT NULL,
  `organization_name` varchar(100) default NULL,
  `zip` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  `approver_id` int(11) default NULL,
  `approved_at` datetime default NULL,
  `approved` tinyint(1) default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `updated_by` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_profiles_on_email` (`email`),
  KEY `index_profiles_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL auto_increment,
  `performance` int(11) default NULL,
  `team` int(11) default NULL,
  `strategy` int(11) default NULL,
  `terms` int(11) default NULL,
  `overall` int(11) default NULL,
  `user_id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_ratings_on_id` (`id`),
  KEY `index_ratings_on_manager_id` (`manager_id`),
  KEY `index_ratings_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `roles_users` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `secondaries` (
  `id` int(11) NOT NULL auto_increment,
  `secondary_type` varchar(255) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `vintage` int(11) default NULL,
  `approver_id` int(11) default NULL,
  `approved_at` datetime default NULL,
  `status` varchar(255) default 'approved',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `expected_price` varchar(255) NOT NULL,
  `bite_size` int(11) default NULL,
  `notes` varchar(255) default NULL,
  `description` text,
  `user_id` int(11) default NULL,
  `updated_by` int(11) default NULL,
  `created_by` int(11) default NULL,
  `net_asset_value` varchar(255) default NULL,
  `drawn` varchar(255) default NULL,
  `commitment_size` varchar(255) default NULL,
  `fund_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_secondaries_on_id` (`id`),
  KEY `index_secondaries_on_manager_id` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sectors` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `simple_captcha_data` (
  `id` int(11) NOT NULL auto_increment,
  `key` varchar(40) default NULL,
  `value` varchar(6) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_activities` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `activity` varchar(255) NOT NULL,
  `regarding_type` varchar(255) NOT NULL,
  `regarding_id` varchar(255) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(100) NOT NULL,
  `crypted_password` varchar(40) NOT NULL,
  `salt` varchar(40) NOT NULL,
  `remember_token` varchar(40) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `plan_id` int(11) NOT NULL,
  `comment_anonymous_count` int(11) default NULL,
  `approver_id` int(11) default NULL,
  `approved_at` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `updated_by` int(11) default NULL,
  `manager_id` int(11) default NULL,
  `emails` int(11) default '0',
  `replies` int(11) default '0',
  `views` int(11) default '0',
  `email_alias` varchar(255) NOT NULL,
  `paid` tinyint(1) default '0',
  `status` varchar(255) default 'unapproved',
  `activation_code` varchar(255) default NULL,
  `credit` int(11) default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_login` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO schema_migrations (version) VALUES ('20090513204723');

INSERT INTO schema_migrations (version) VALUES ('20090513205858');

INSERT INTO schema_migrations (version) VALUES ('20090513210528');

INSERT INTO schema_migrations (version) VALUES ('20090513210619');

INSERT INTO schema_migrations (version) VALUES ('20090513210749');

INSERT INTO schema_migrations (version) VALUES ('20090513211113');

INSERT INTO schema_migrations (version) VALUES ('20090513211326');

INSERT INTO schema_migrations (version) VALUES ('20090513211811');

INSERT INTO schema_migrations (version) VALUES ('20090513211920');

INSERT INTO schema_migrations (version) VALUES ('20090513212042');

INSERT INTO schema_migrations (version) VALUES ('20090513212134');

INSERT INTO schema_migrations (version) VALUES ('20090513212309');

INSERT INTO schema_migrations (version) VALUES ('20090513212434');

INSERT INTO schema_migrations (version) VALUES ('20090513213215');

INSERT INTO schema_migrations (version) VALUES ('20090513213414');

INSERT INTO schema_migrations (version) VALUES ('20090513213915');

INSERT INTO schema_migrations (version) VALUES ('20090513214237');

INSERT INTO schema_migrations (version) VALUES ('20090513223426');

INSERT INTO schema_migrations (version) VALUES ('20090514071001');

INSERT INTO schema_migrations (version) VALUES ('20090514091125');

INSERT INTO schema_migrations (version) VALUES ('20090514093414');

INSERT INTO schema_migrations (version) VALUES ('20090515104947');

INSERT INTO schema_migrations (version) VALUES ('20090519143010');

INSERT INTO schema_migrations (version) VALUES ('20090520050631');

INSERT INTO schema_migrations (version) VALUES ('20090520063103');

INSERT INTO schema_migrations (version) VALUES ('20090521065643');

INSERT INTO schema_migrations (version) VALUES ('20090521073244');

INSERT INTO schema_migrations (version) VALUES ('20090522090510');

INSERT INTO schema_migrations (version) VALUES ('20090522114716');

INSERT INTO schema_migrations (version) VALUES ('20090526074515');

INSERT INTO schema_migrations (version) VALUES ('20090527070505');

INSERT INTO schema_migrations (version) VALUES ('20090527072025');

INSERT INTO schema_migrations (version) VALUES ('20090528074424');

INSERT INTO schema_migrations (version) VALUES ('20090528135101');

INSERT INTO schema_migrations (version) VALUES ('20090529045200');

INSERT INTO schema_migrations (version) VALUES ('20090529070743');

INSERT INTO schema_migrations (version) VALUES ('20090529112627');

INSERT INTO schema_migrations (version) VALUES ('20090530101930');

INSERT INTO schema_migrations (version) VALUES ('20090530103242');

INSERT INTO schema_migrations (version) VALUES ('20090530120357');

INSERT INTO schema_migrations (version) VALUES ('20090601075057');

INSERT INTO schema_migrations (version) VALUES ('20090601171343');

INSERT INTO schema_migrations (version) VALUES ('20090603134603');

INSERT INTO schema_migrations (version) VALUES ('20090603195908');

INSERT INTO schema_migrations (version) VALUES ('20090604062448');

INSERT INTO schema_migrations (version) VALUES ('20090604065219');

INSERT INTO schema_migrations (version) VALUES ('20090605035952');

INSERT INTO schema_migrations (version) VALUES ('20090605043809');

INSERT INTO schema_migrations (version) VALUES ('20090605122130');

INSERT INTO schema_migrations (version) VALUES ('20090605183641');

INSERT INTO schema_migrations (version) VALUES ('20090605193223');

INSERT INTO schema_migrations (version) VALUES ('20090608080339');

INSERT INTO schema_migrations (version) VALUES ('20090608113836');

INSERT INTO schema_migrations (version) VALUES ('20090611065318');

INSERT INTO schema_migrations (version) VALUES ('20090612055212');

INSERT INTO schema_migrations (version) VALUES ('20090612095531');

INSERT INTO schema_migrations (version) VALUES ('20090615082054');

INSERT INTO schema_migrations (version) VALUES ('20090615105323');

INSERT INTO schema_migrations (version) VALUES ('20090615113553');

INSERT INTO schema_migrations (version) VALUES ('20090616063853');

INSERT INTO schema_migrations (version) VALUES ('20090616085102');

INSERT INTO schema_migrations (version) VALUES ('20090616091623');

INSERT INTO schema_migrations (version) VALUES ('20090616095620');

INSERT INTO schema_migrations (version) VALUES ('20090616134439');

INSERT INTO schema_migrations (version) VALUES ('20090617070402');

INSERT INTO schema_migrations (version) VALUES ('20090618112253');

INSERT INTO schema_migrations (version) VALUES ('20090618142624');

INSERT INTO schema_migrations (version) VALUES ('20090619071452');

INSERT INTO schema_migrations (version) VALUES ('20090619114149');

INSERT INTO schema_migrations (version) VALUES ('20090621204810');

INSERT INTO schema_migrations (version) VALUES ('20090622131901');

INSERT INTO schema_migrations (version) VALUES ('20090623125953');

INSERT INTO schema_migrations (version) VALUES ('20090625154949');

INSERT INTO schema_migrations (version) VALUES ('20090626074312');

INSERT INTO schema_migrations (version) VALUES ('20090627065106');

INSERT INTO schema_migrations (version) VALUES ('20090629063305');

INSERT INTO schema_migrations (version) VALUES ('20090701142432');

INSERT INTO schema_migrations (version) VALUES ('20090701142715');

INSERT INTO schema_migrations (version) VALUES ('20090703134151');

INSERT INTO schema_migrations (version) VALUES ('20090706140259');

INSERT INTO schema_migrations (version) VALUES ('20090709101144');

INSERT INTO schema_migrations (version) VALUES ('20090709121414');

INSERT INTO schema_migrations (version) VALUES ('20090709131931');

INSERT INTO schema_migrations (version) VALUES ('20090710102423');

INSERT INTO schema_migrations (version) VALUES ('20090713052413');

INSERT INTO schema_migrations (version) VALUES ('20090713063536');

INSERT INTO schema_migrations (version) VALUES ('20090713075145');

INSERT INTO schema_migrations (version) VALUES ('20090714065148');

INSERT INTO schema_migrations (version) VALUES ('20090714125310');

INSERT INTO schema_migrations (version) VALUES ('20090715050731');

INSERT INTO schema_migrations (version) VALUES ('20090716045230');

INSERT INTO schema_migrations (version) VALUES ('20090716065505');

INSERT INTO schema_migrations (version) VALUES ('20090716094903');

INSERT INTO schema_migrations (version) VALUES ('20090717100805');

INSERT INTO schema_migrations (version) VALUES ('20090720124624');

INSERT INTO schema_migrations (version) VALUES ('20090721052946');

INSERT INTO schema_migrations (version) VALUES ('20090722064705');

INSERT INTO schema_migrations (version) VALUES ('20090722080104');

INSERT INTO schema_migrations (version) VALUES ('20090723083014');

INSERT INTO schema_migrations (version) VALUES ('20090724060211');

INSERT INTO schema_migrations (version) VALUES ('20090724080725');

INSERT INTO schema_migrations (version) VALUES ('20090724091832');

INSERT INTO schema_migrations (version) VALUES ('20090725064353');

INSERT INTO schema_migrations (version) VALUES ('20090818105032');

INSERT INTO schema_migrations (version) VALUES ('20090904075424');