class JsonResponseSimulator {
  static Map<String, dynamic> profile = {
    "id": 4,
    "username": "test2",
    "name": "changed",
    "first_name": "changed",
    "last_name": "changed",
    "email": "changed@gmail.com",
    "url": "http://changed%202",
    "description": "changed",
    "link": "https://localhost/wordpress_test/author/changed/",
    "locale": "fa_IR",
    "nickname": "changed",
    "slug": "changed",
    "roles": ["administrator"],
    "registered_date": "2024-10-16T13:42:03+00:00",
    "capabilities": {
      "switch_themes": true,
      "edit_themes": true,
      "activate_plugins": true,
      "edit_plugins": true,
      "edit_users": true,
      "edit_files": true,
      "manage_options": true,
      "moderate_comments": true,
      "manage_categories": true,
      "manage_links": true,
      "upload_files": true,
      "import": true,
      "unfiltered_html": true,
      "edit_posts": true,
      "edit_others_posts": true,
      "edit_published_posts": true,
      "publish_posts": true,
      "edit_pages": true,
      "read": true,
      "level_10": true,
      "level_9": true,
      "level_8": true,
      "level_7": true,
      "level_6": true,
      "level_5": true,
      "level_4": true,
      "level_3": true,
      "level_2": true,
      "level_1": true,
      "level_0": true,
      "edit_others_pages": true,
      "edit_published_pages": true,
      "publish_pages": true,
      "delete_pages": true,
      "delete_others_pages": true,
      "delete_published_pages": true,
      "delete_posts": true,
      "delete_others_posts": true,
      "delete_published_posts": true,
      "delete_private_posts": true,
      "edit_private_posts": true,
      "read_private_posts": true,
      "delete_private_pages": true,
      "edit_private_pages": true,
      "read_private_pages": true,
      "delete_users": true,
      "create_users": true,
      "unfiltered_upload": true,
      "edit_dashboard": true,
      "update_plugins": true,
      "delete_plugins": true,
      "install_plugins": true,
      "update_themes": true,
      "install_themes": true,
      "update_core": true,
      "list_users": true,
      "remove_users": true,
      "promote_users": true,
      "edit_theme_options": true,
      "delete_themes": true,
      "export": true,
      "administrator": true
    },
    "extra_capabilities": {"administrator": true},
    "avatar_urls": {
      "24":
          "https://secure.gravatar.com/avatar/246ece844011faeec5d133e9f73d150a?s=24&d=mm&r=g",
      "48":
          "https://secure.gravatar.com/avatar/246ece844011faeec5d133e9f73d150a?s=48&d=mm&r=g",
      "96":
          "https://secure.gravatar.com/avatar/246ece844011faeec5d133e9f73d150a?s=96&d=mm&r=g"
    },
    "meta": {"persisted_preferences": []},
    "acf": {"book": false},
    "_links": {
      "self": [
        {"href": "https://localhost/wordpress_test/wp-json/wp/v2/users/4"}
      ],
      "collection": [
        {"href": "https://localhost/wordpress_test/wp-json/wp/v2/users"}
      ]
    }
  };

  static Map<String, dynamic> siteSettings = {
    "title": "wordpress_test",
    "description": "",
    "url": "http://localhost/wordpress_test",
    "email": "example@gmail.com",
    "timezone": "Atlantic/Azores",
    "date_format": "F j, Y",
    "time_format": "g:i a",
    "start_of_week": 1,
    "language": "fa_IR",
    "use_smilies": true,
    "default_category": 1,
    "default_post_format": "0",
    "posts_per_page": 10,
    "show_on_front": "posts",
    "page_on_front": 0,
    "page_for_posts": 0,
    "default_ping_status": "open",
    "default_comment_status": "open",
    "site_logo": null,
    "site_icon": 37,
    "jwt_auth_options": {"share_data": false}
  };

  static Map<String, dynamic> media = {
    "id": 42,
    "date": "2024-10-24T14:58:10",
    "date_gmt": "2024-10-24T11:28:10",
    "guid": {
      "rendered":
          "http://localhost/wordpress_test/wp-content/uploads/2024/10/test.zip",
      "raw":
          "http://localhost/wordpress_test/wp-content/uploads/2024/10/test.zip"
    },
    "modified": "2024-10-24T14:58:10",
    "modified_gmt": "2024-10-24T11:28:10",
    "slug": "test-2",
    "status": "inherit",
    "type": "attachment",
    "link": "https://localhost/wordpress_test/test-2/",
    "title": {"raw": "test", "rendered": "test"},
    "author": 4,
    "featured_media": 0,
    "comment_status": "open",
    "ping_status": "closed",
    "template": "",
    "meta": {"_acf_changed": false},
    "permalink_template": "https://localhost/wordpress_test/?attachment_id=42",
    "generated_slug": "test-2",
    "class_list": [
      "post-42",
      "attachment",
      "type-attachment",
      "status-inherit",
      "hentry"
    ],
    "acf": [],
    "description": {
      "raw": "",
      "rendered":
          "<p class=\"attachment\"><a href='https://localhost/wordpress_test/wp-content/uploads/2024/10/test.zip'>test</a></p>\n"
    },
    "caption": {"raw": "", "rendered": "<p>test</p>\n"},
    "alt_text": "",
    "media_type": "file",
    "mime_type": "application/zip",
    "media_details": {"filesize": 114, "sizes": {}},
    "post": null,
    "source_url":
        "https://localhost/wordpress_test/wp-content/uploads/2024/10/test.zip",
    "missing_image_sizes": [],
    "_links": {
      "self": [
        {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/42"}
      ],
      "collection": [
        {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media"}
      ],
      "about": [
        {
          "href":
              "https://localhost/wordpress_test/wp-json/wp/v2/types/attachment"
        }
      ],
      "author": [
        {
          "embeddable": true,
          "href": "https://localhost/wordpress_test/wp-json/wp/v2/users/4"
        }
      ],
      "replies": [
        {
          "embeddable": true,
          "href":
              "https://localhost/wordpress_test/wp-json/wp/v2/comments?post=42"
        }
      ],
      "wp:action-unfiltered-html": [
        {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/42"}
      ],
      "wp:action-assign-author": [
        {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/42"}
      ],
      "curies": [
        {"name": "wp", "href": "https://api.w.org/{rel}", "templated": true}
      ]
    },
    "_embedded": {
      "author": [
        {
          "id": 4,
          "name": "test3",
          "url": "https://google3.com",
          "description": "جدید توضیحات",
          "link": "https://localhost/wordpress_test/author/jafar/",
          "slug": "jafar",
          "avatar_urls": {
            "24":
                "https://secure.gravatar.com/avatar/246ece844011faeec5d133e9f73d150a?s=24&d=mm&r=g",
            "48":
                "https://secure.gravatar.com/avatar/246ece844011faeec5d133e9f73d150a?s=48&d=mm&r=g",
            "96":
                "https://secure.gravatar.com/avatar/246ece844011faeec5d133e9f73d150a?s=96&d=mm&r=g"
          },
          "acf": {"book": false},
          "_links": {
            "self": [
              {"href": "https://localhost/wordpress_test/wp-json/wp/v2/users/4"}
            ],
            "collection": [
              {"href": "https://localhost/wordpress_test/wp-json/wp/v2/users"}
            ]
          }
        }
      ]
    }
  };

  static List<Map<String, dynamic>> mediaList = [
    media,
    media,
    media,
    media,
  ];
}
