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

  static Map<String, dynamic> post = {
    "id": 1,
    "date": "2024-11-03T06:48:42",
    "date_gmt": "2024-11-03T06:48:42",
    "guid": {
      "rendered": "https://syntaxforge.ir/?p=1",
      "raw": "https://syntaxforge.ir/?p=1"
    },
    "modified": "2024-11-09T18:29:50",
    "modified_gmt": "2024-11-09T14:59:50",
    "password": "",
    "slug": "hello-world",
    "status": "publish",
    "type": "post",
    "link": "https://syntaxforge.ir/2024/11/03/hello-world/",
    "title": {"raw": "Hello world!", "rendered": "Hello world!"},
    "content": {
      "raw":
          "<!-- wp:paragraph -->\r\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\r\n<!-- /wp:paragraph -->",
      "rendered":
          "\r\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\r\n",
      "protected": false,
      "block_version": 1
    },
    "excerpt": {
      "raw": "",
      "rendered":
          "<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\n",
      "protected": false
    },
    "author": 1,
    "featured_media": 102,
    "comment_status": "open",
    "ping_status": "open",
    "sticky": false,
    "template": "",
    "format": "standard",
    "meta": {"footnotes": ""},
    "categories": [1],
    "tags": [3],
    "permalink_template": "https://syntaxforge.ir/2024/11/03/%postname%/",
    "generated_slug": "hello-world",
    "class_list": [
      "post-1",
      "post",
      "type-post",
      "status-publish",
      "format-standard",
      "has-post-thumbnail",
      "hentry",
      "category-uncategorized",
      "tag-test"
    ],
    "_links": {
      "self": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1"}
      ],
      "collection": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts"}
      ],
      "about": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/types/post"}
      ],
      "author": [
        {
          "embeddable": true,
          "href": "https://syntaxforge.ir/wp-json/wp/v2/users/1"
        }
      ],
      "replies": [
        {
          "embeddable": true,
          "href": "https://syntaxforge.ir/wp-json/wp/v2/comments?post=1"
        }
      ],
      "version-history": [
        {
          "count": 1,
          "href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1/revisions"
        }
      ],
      "predecessor-version": [
        {
          "id": 119,
          "href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1/revisions/119"
        }
      ],
      "wp:featuredmedia": [
        {
          "embeddable": true,
          "href": "https://syntaxforge.ir/wp-json/wp/v2/media/102"
        }
      ],
      "wp:attachment": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/media?parent=1"}
      ],
      "wp:term": [
        {
          "taxonomy": "category",
          "embeddable": true,
          "href": "https://syntaxforge.ir/wp-json/wp/v2/categories?post=1"
        },
        {
          "taxonomy": "post_tag",
          "embeddable": true,
          "href": "https://syntaxforge.ir/wp-json/wp/v2/tags?post=1"
        }
      ],
      "wp:action-publish": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1"}
      ],
      "wp:action-unfiltered-html": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1"}
      ],
      "wp:action-sticky": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1"}
      ],
      "wp:action-assign-author": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1"}
      ],
      "wp:action-create-categories": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1"}
      ],
      "wp:action-assign-categories": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1"}
      ],
      "wp:action-create-tags": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1"}
      ],
      "wp:action-assign-tags": [
        {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts/1"}
      ],
      "curies": [
        {"name": "wp", "href": "https://api.w.org/{rel}", "templated": true}
      ]
    },
    "_embedded": {
      "author": [
        {
          "id": 1,
          "name": "syntax",
          "url": "https://syntaxforge.ir",
          "description": "",
          "link": "https://syntaxforge.ir/author/syntax/",
          "slug": "syntax",
          "avatar_urls": {
            "24":
                "https://secure.gravatar.com/avatar/0952786969e4f4a931e353563ebabd68?s=24&d=mm&r=g",
            "48":
                "https://secure.gravatar.com/avatar/0952786969e4f4a931e353563ebabd68?s=48&d=mm&r=g",
            "96":
                "https://secure.gravatar.com/avatar/0952786969e4f4a931e353563ebabd68?s=96&d=mm&r=g"
          },
          "_links": {
            "self": [
              {"href": "https://syntaxforge.ir/wp-json/wp/v2/users/1"}
            ],
            "collection": [
              {"href": "https://syntaxforge.ir/wp-json/wp/v2/users"}
            ]
          }
        }
      ],
      "wp:featuredmedia": [
        {
          "id": 102,
          "date": "2024-11-05T17:35:04",
          "slug": "edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-4",
          "type": "attachment",
          "link":
              "https://syntaxforge.ir/edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-4/",
          "title": {"rendered": "edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu"},
          "author": 1,
          "featured_media": 0,
          "caption": {"rendered": ""},
          "alt_text": "",
          "media_type": "image",
          "mime_type": "image/jpeg",
          "media_details": {
            "width": 564,
            "height": 1006,
            "file": "2024/11/edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-3.jpg",
            "filesize": 85166,
            "sizes": {
              "medium": {
                "file":
                    "edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-3-168x300.jpg",
                "width": 168,
                "height": 300,
                "filesize": 13758,
                "mime_type": "image/jpeg",
                "source_url":
                    "https://syntaxforge.ir/wp-content/uploads/2024/11/edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-3-168x300.jpg"
              },
              "thumbnail": {
                "file":
                    "edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-3-150x150.jpg",
                "width": 150,
                "height": 150,
                "filesize": 8151,
                "mime_type": "image/jpeg",
                "source_url":
                    "https://syntaxforge.ir/wp-content/uploads/2024/11/edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-3-150x150.jpg"
              },
              "full": {
                "file": "edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-3.jpg",
                "width": 564,
                "height": 1006,
                "mime_type": "image/jpeg",
                "source_url":
                    "https://syntaxforge.ir/wp-content/uploads/2024/11/edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-3.jpg"
              }
            },
            "image_meta": {
              "aperture": "0",
              "credit": "",
              "camera": "",
              "caption": "",
              "created_timestamp": "0",
              "copyright": "",
              "focal_length": "0",
              "iso": "0",
              "shutter_speed": "0",
              "title": "",
              "orientation": "0",
              "keywords": []
            }
          },
          "source_url":
              "https://syntaxforge.ir/wp-content/uploads/2024/11/edcf8ba0-2809-47f0-a40a-f8432e5e7867-cpu-3.jpg",
          "_links": {
            "self": [
              {"href": "https://syntaxforge.ir/wp-json/wp/v2/media/102"}
            ],
            "collection": [
              {"href": "https://syntaxforge.ir/wp-json/wp/v2/media"}
            ],
            "about": [
              {"href": "https://syntaxforge.ir/wp-json/wp/v2/types/attachment"}
            ],
            "author": [
              {
                "embeddable": true,
                "href": "https://syntaxforge.ir/wp-json/wp/v2/users/1"
              }
            ],
            "replies": [
              {
                "embeddable": true,
                "href": "https://syntaxforge.ir/wp-json/wp/v2/comments?post=102"
              }
            ]
          }
        }
      ],
      "wp:term": [
        [
          {
            "id": 1,
            "link": "https://syntaxforge.ir/category/uncategorized/",
            "name": "Uncategorized",
            "slug": "uncategorized",
            "taxonomy": "category",
            "_links": {
              "self": [
                {"href": "https://syntaxforge.ir/wp-json/wp/v2/categories/1"}
              ],
              "collection": [
                {"href": "https://syntaxforge.ir/wp-json/wp/v2/categories"}
              ],
              "about": [
                {
                  "href":
                      "https://syntaxforge.ir/wp-json/wp/v2/taxonomies/category"
                }
              ],
              "wp:post_type": [
                {
                  "href":
                      "https://syntaxforge.ir/wp-json/wp/v2/posts?categories=1"
                }
              ],
              "curies": [
                {
                  "name": "wp",
                  "href": "https://api.w.org/{rel}",
                  "templated": true
                }
              ]
            }
          }
        ],
        [
          {
            "id": 3,
            "link": "https://syntaxforge.ir/tag/test/",
            "name": "test",
            "slug": "test",
            "taxonomy": "post_tag",
            "_links": {
              "self": [
                {"href": "https://syntaxforge.ir/wp-json/wp/v2/tags/3"}
              ],
              "collection": [
                {"href": "https://syntaxforge.ir/wp-json/wp/v2/tags"}
              ],
              "about": [
                {
                  "href":
                      "https://syntaxforge.ir/wp-json/wp/v2/taxonomies/post_tag"
                }
              ],
              "wp:post_type": [
                {"href": "https://syntaxforge.ir/wp-json/wp/v2/posts?tags=3"}
              ],
              "curies": [
                {
                  "name": "wp",
                  "href": "https://api.w.org/{rel}",
                  "templated": true
                }
              ]
            }
          }
        ]
      ]
    }
  };

  static Map<String, dynamic> forcePostDeleted = {
    "deleted": true,
    "previous": {
      "id": 143,
      "date": "2024-11-12T12:53:13",
      "date_gmt": "2024-11-12T09:23:13",
      "guid": {
        "rendered": "https://syntaxforge.ir/?p=143",
        "raw": "https://syntaxforge.ir/?p=143"
      },
      "modified": "2024-11-14T22:49:46",
      "modified_gmt": "2024-11-14T19:19:46",
      "password": "",
      "slug": "test11",
      "status": "pending",
      "type": "post",
      "link": "https://syntaxforge.ir/?p=143",
      "title": {"raw": "test11 updated5", "rendered": "test11 updated5"},
      "content": {
        "raw": "",
        "rendered": "",
        "protected": false,
        "block_version": 0
      },
      "excerpt": {"raw": "", "rendered": "", "protected": false},
      "author": 1,
      "featured_media": 0,
      "comment_status": "open",
      "ping_status": "open",
      "sticky": false,
      "template": "",
      "format": "standard",
      "meta": {"footnotes": ""},
      "categories": [1],
      "tags": [],
      "permalink_template": "https://syntaxforge.ir/2024/11/12/%postname%/",
      "generated_slug": "test11-updated5",
      "class_list": [
        "post-143",
        "post",
        "type-post",
        "status-pending",
        "format-standard",
        "hentry",
        "category-uncategorized"
      ]
    }
  };
}
