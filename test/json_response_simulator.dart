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
    }
  };

  static List<Map<String, dynamic>> mediaList = [
    {
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
      "permalink_template":
          "https://localhost/wordpress_test/?attachment_id=42",
      "generated_slug": "test",
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
      }
    },
    {
      "id": 41,
      "date": "2024-10-24T14:57:21",
      "date_gmt": "2024-10-24T11:27:21",
      "guid": {
        "rendered":
            "http://localhost/wordpress_test/wp-content/uploads/2024/10/Counter-strike-2-2024.05.01-21.27.18.03.DVR_.mp4",
        "raw":
            "http://localhost/wordpress_test/wp-content/uploads/2024/10/Counter-strike-2-2024.05.01-21.27.18.03.DVR_.mp4"
      },
      "modified": "2024-10-24T14:57:21",
      "modified_gmt": "2024-10-24T11:27:21",
      "slug": "counter-strike-2-2024-05-01-21-27-18-03-dvr",
      "status": "inherit",
      "type": "attachment",
      "link":
          "https://localhost/wordpress_test/counter-strike-2-2024-05-01-21-27-18-03-dvr/",
      "title": {
        "raw": "Counter-strike 2 2024.05.01 - 21.27.18.03.DVR",
        "rendered": "Counter-strike 2 2024.05.01 &#8211; 21.27.18.03.DVR"
      },
      "author": 4,
      "featured_media": 0,
      "comment_status": "open",
      "ping_status": "closed",
      "template": "",
      "meta": {"_acf_changed": false},
      "permalink_template":
          "https://localhost/wordpress_test/?attachment_id=41",
      "generated_slug": "counter-strike-2-2024-05-01-21-27-18-03-dvr",
      "class_list": [
        "post-41",
        "attachment",
        "type-attachment",
        "status-inherit",
        "hentry"
      ],
      "acf": [],
      "description": {
        "raw": "",
        "rendered":
            "<div style=\"width: 960px;\" class=\"wp-video\"><!--[if lt IE 9]><script>document.createElement('video');</script><![endif]-->\n<video class=\"wp-video-shortcode\" id=\"video-41-1\" width=\"960\" height=\"720\" preload=\"metadata\" controls=\"controls\"><source type=\"video/mp4\" src=\"https://localhost/wordpress_test/wp-content/uploads/2024/10/Counter-strike-2-2024.05.01-21.27.18.03.DVR_.mp4?_=1\" /><a href=\"https://localhost/wordpress_test/wp-content/uploads/2024/10/Counter-strike-2-2024.05.01-21.27.18.03.DVR_.mp4\">https://localhost/wordpress_test/wp-content/uploads/2024/10/Counter-strike-2-2024.05.01-21.27.18.03.DVR_.mp4</a></video></div>\n"
      },
      "caption": {
        "raw": "",
        "rendered":
            "<p>https://localhost/wordpress_test/wp-content/uploads/2024/10/Counter-strike-2-2024.05.01-21.27.18.03.DVR_.mp4</p>\n"
      },
      "alt_text": "",
      "media_type": "file",
      "mime_type": "video/mp4",
      "media_details": {
        "bitrate": 14276251,
        "filesize": 54016341,
        "mime_type": "video/mp4",
        "length": 30,
        "length_formatted": "0:30",
        "width": 960,
        "height": 720,
        "fileformat": "mp4",
        "dataformat": "quicktime",
        "audio": {
          "dataformat": "mp4",
          "bitrate": 96000,
          "codec": "ISO/IEC 14496-3 AAC",
          "sample_rate": 48000,
          "channels": 2,
          "bits_per_sample": 16,
          "lossless": false,
          "channelmode": "stereo",
          "compression_ratio": 0.0625
        },
        "created_timestamp": 1714586239,
        "sizes": {}
      },
      "post": null,
      "source_url":
          "https://localhost/wordpress_test/wp-content/uploads/2024/10/Counter-strike-2-2024.05.01-21.27.18.03.DVR_.mp4",
      "missing_image_sizes": [],
      "_links": {
        "self": [
          {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/41"}
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
                "https://localhost/wordpress_test/wp-json/wp/v2/comments?post=41"
          }
        ],
        "wp:action-unfiltered-html": [
          {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/41"}
        ],
        "wp:action-assign-author": [
          {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/41"}
        ],
        "curies": [
          {"name": "wp", "href": "https://api.w.org/{rel}", "templated": true}
        ]
      }
    },
    {
      "id": 37,
      "date": "2024-10-07T20:06:27",
      "date_gmt": "2024-10-07T16:36:27",
      "guid": {
        "rendered":
            "http://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower.jpg",
        "raw":
            "http://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower.jpg"
      },
      "modified": "2024-10-07T20:06:27",
      "modified_gmt": "2024-10-07T16:36:27",
      "slug": "cropped-flower-jpg",
      "status": "inherit",
      "type": "attachment",
      "link": "https://localhost/wordpress_test/?attachment_id=37",
      "title": {"raw": "cropped-flower.jpg", "rendered": "cropped-flower.jpg"},
      "author": 4,
      "featured_media": 0,
      "comment_status": "open",
      "ping_status": "closed",
      "template": "",
      "meta": {"_acf_changed": false},
      "permalink_template":
          "https://localhost/wordpress_test/?attachment_id=37",
      "generated_slug": "cropped-flower-jpg",
      "class_list": [
        "post-37",
        "attachment",
        "type-attachment",
        "status-inherit",
        "hentry"
      ],
      "acf": [],
      "description": {
        "raw":
            "http://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower.jpg",
        "rendered":
            "<p class=\"attachment\"><a href='https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower.jpg'><img loading=\"lazy\" decoding=\"async\" width=\"300\" height=\"300\" src=\"https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-300x300.jpg\" class=\"attachment-medium size-medium\" alt=\"\" srcset=\"https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-300x300.jpg 300w, https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-150x150.jpg 150w, https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-270x270.jpg 270w, https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-192x192.jpg 192w, https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-180x180.jpg 180w, https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-32x32.jpg 32w, https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower.jpg 512w\" sizes=\"(max-width: 300px) 100vw, 300px\" /></a></p>\n<p>http://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower.jpg</p>\n"
      },
      "caption": {"raw": "مختصر caption", "rendered": "<p>مختصر caption</p>\n"},
      "alt_text": "",
      "media_type": "image",
      "mime_type": "image/jpeg",
      "media_details": {
        "width": 512,
        "height": 512,
        "file": "2024/10/cropped-flower.jpg",
        "filesize": 31233,
        "sizes": {
          "medium": {
            "file": "cropped-flower-300x300.jpg",
            "width": 300,
            "height": 300,
            "filesize": 13674,
            "mime_type": "image/jpeg",
            "source_url":
                "https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-300x300.jpg"
          },
          "thumbnail": {
            "file": "cropped-flower-150x150.jpg",
            "width": 150,
            "height": 150,
            "filesize": 5497,
            "mime_type": "image/jpeg",
            "source_url":
                "https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-150x150.jpg"
          },
          "site_icon-270": {
            "file": "cropped-flower-270x270.jpg",
            "width": 270,
            "height": 270,
            "filesize": 11771,
            "mime_type": "image/jpeg",
            "source_url":
                "https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-270x270.jpg"
          },
          "site_icon-192": {
            "file": "cropped-flower-192x192.jpg",
            "width": 192,
            "height": 192,
            "filesize": 7412,
            "mime_type": "image/jpeg",
            "source_url":
                "https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-192x192.jpg"
          },
          "site_icon-180": {
            "file": "cropped-flower-180x180.jpg",
            "width": 180,
            "height": 180,
            "filesize": 6790,
            "mime_type": "image/jpeg",
            "source_url":
                "https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-180x180.jpg"
          },
          "site_icon-32": {
            "file": "cropped-flower-32x32.jpg",
            "width": 32,
            "height": 32,
            "filesize": 1147,
            "mime_type": "image/jpeg",
            "source_url":
                "https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower-32x32.jpg"
          },
          "full": {
            "file": "cropped-flower.jpg",
            "width": 512,
            "height": 512,
            "mime_type": "image/jpeg",
            "source_url":
                "https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower.jpg"
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
      "post": 31,
      "source_url":
          "https://localhost/wordpress_test/wp-content/uploads/2024/10/cropped-flower.jpg",
      "missing_image_sizes": [],
      "_links": {
        "self": [
          {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/37"}
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
                "https://localhost/wordpress_test/wp-json/wp/v2/comments?post=37"
          }
        ],
        "wp:action-unfiltered-html": [
          {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/37"}
        ],
        "wp:action-assign-author": [
          {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/37"}
        ],
        "curies": [
          {"name": "wp", "href": "https://api.w.org/{rel}", "templated": true}
        ]
      }
    },
    {
      "id": 9,
      "date": "2024-09-25T14:45:15",
      "date_gmt": "2024-09-25T14:45:15",
      "guid": {
        "rendered":
            "http://localhost/wordpress_test/wp-content/uploads/2024/09/جعفر-رضازاده-1.pdf",
        "raw":
            "http://localhost/wordpress_test/wp-content/uploads/2024/09/جعفر-رضازاده-1.pdf"
      },
      "modified": "2024-10-24T20:53:00",
      "modified_gmt": "2024-10-24T17:23:00",
      "slug":
          "%d8%ac%d8%b9%d9%81%d8%b1-%d8%b1%d8%b6%d8%a7%d8%b2%d8%a7%d8%af%d9%87-2",
      "status": "inherit",
      "type": "attachment",
      "link":
          "https://localhost/wordpress_test/%d8%ac%d8%b9%d9%81%d8%b1-%d8%b1%d8%b6%d8%a7%d8%b2%d8%a7%d8%af%d9%87-2/",
      "title": {"raw": "title", "rendered": "title"},
      "author": 1,
      "featured_media": 0,
      "comment_status": "open",
      "ping_status": "closed",
      "template": "",
      "meta": {"_acf_changed": false},
      "permalink_template": "https://localhost/wordpress_test/?attachment_id=9",
      "generated_slug": "title",
      "class_list": [
        "post-9",
        "attachment",
        "type-attachment",
        "status-inherit",
        "hentry"
      ],
      "acf": [],
      "description": {
        "raw": "description ",
        "rendered":
            "<p class=\"attachment\"><a href='https://localhost/wordpress_test/wp-content/uploads/2024/09/جعفر-رضازاده-1.pdf'>title</a></p>\n<p>description </p>\n"
      },
      "caption": {"raw": "hello", "rendered": "<p>hello</p>\n"},
      "alt_text": "متن جایگزین alt text",
      "media_type": "file",
      "mime_type": "application/pdf",
      "media_details": {"filesize": 96206, "sizes": {}},
      "post": null,
      "source_url":
          "https://localhost/wordpress_test/wp-content/uploads/2024/09/جعفر-رضازاده-1.pdf",
      "missing_image_sizes": [],
      "_links": {
        "self": [
          {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/9"}
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
            "href": "https://localhost/wordpress_test/wp-json/wp/v2/users/1"
          }
        ],
        "replies": [
          {
            "embeddable": true,
            "href":
                "https://localhost/wordpress_test/wp-json/wp/v2/comments?post=9"
          }
        ],
        "wp:action-unfiltered-html": [
          {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/9"}
        ],
        "wp:action-assign-author": [
          {"href": "https://localhost/wordpress_test/wp-json/wp/v2/media/9"}
        ],
        "curies": [
          {"name": "wp", "href": "https://api.w.org/{rel}", "templated": true}
        ]
      }
    }
  ];
}
