Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD8328AF
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCKuDLjD"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6b709048f32so1866162b3a.0
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700230350; x=1700835150; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gmWj6X7RSE29Em8B+Z/0I5UE5yMatrN+9iIGBbc4/g=;
        b=LCKuDLjDU6SHxE7j2PfYj2dNz/iJPkGbGC1JFYDDMvxvlffVyboUFPx9udCkFsjbP0
         Vbymz7li0L0FLT9coYKdqlESNMU9wH2cAFb6V6TQzGAyEe92SVIW7SZvMwfNEu5DpXe3
         WqdhdjR/0xu4UR0A2UkVvMYE2rsPhn1C321dvVGD7Y9XVq63P0NrFUk03A7FD3MpMAy9
         lsRFMvlA6tRe9lReLP4Ub1sODzIwx1or/rEfIp636SauI3DsXadVHAc7BQD8cPWDyZMS
         QXiG2XBfIs53cmKcTDOb4FC+Zi+wHgc3Hrm7vfFXOj2UI24tFatRYJj4DcdwdKHUf5+a
         0sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230350; x=1700835150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gmWj6X7RSE29Em8B+Z/0I5UE5yMatrN+9iIGBbc4/g=;
        b=s/4OYiz1VSI45xgHUJLOUfAg21ARkWX53FgQhE3YHHr+H5TQTQKtwAZRD6nyswjynS
         Crkp8AadsqdmOEqMzRPjr++lz4+UtXKvDgLxabY33K/WI4ggxvBY4JLUeLgCM8KlxUbW
         WE4puxgzgoNjoqEakxesle0rII3LoeH9hy//dv7olZ2R/EM/O9/G0AWRdXVZHvEDc39Y
         9HcA1jwi5XgzdL83zeu+ZDK6CtnBfwEGLl9S1PfgObQERhUTHkyHmaArfwoDDjhhJWLF
         /1JC1iL6tqQjrrZhy7klI4FZZXoRZa6lWJWi/WrG1kG7yQ454rDy2dHfkrUx8xDXa5UR
         snNw==
X-Gm-Message-State: AOJu0YxjVPiEmJFRPZRacp7GkxIKPbtMJzm/ZNYLwzsmrtG5xJFl5yW6
	JHzWj1dLK9+2jd496+QmvzXMmnItswVIUg==
X-Google-Smtp-Source: AGHT+IGcA+SHBwjGq3K6KCMMvQIH+KHVB4ClmFiuw+kCkKMvsVJ/fWT0G/EYdW2hK0nI5dqlxNlFJQ==
X-Received: by 2002:a05:6a00:ad1:b0:6c9:9e11:859d with SMTP id c17-20020a056a000ad100b006c99e11859dmr11019861pfl.1.1700230350127;
        Fri, 17 Nov 2023 06:12:30 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id t24-20020aa79398000000b006c4db182074sm1447897pfe.196.2023.11.17.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 06:12:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] dpp-util: add support for 3rd party JSON fields
Date: Fri, 17 Nov 2023 06:12:24 -0800
Message-Id: <20231117141227.60722-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPP spec allows 3rd party fields in the DPP configuration
object (section 4.5.2). IWD can take advantage of this (when
configuring another IWD supplicant) to communicate additional
profile options that may be required for the network.

The new configuration member will be called "/net/connman/iwd"
and will be an object containing settings specific to IWD.
More settings could be added here if needed but for now only
the following are defined:

{
  send_hostname: true/false,
  hidden: true/false
}

These correspond to the following network profile settings:

[IPv4].SendHostname
[Settings].Hidden
---
 src/dpp-util.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++---
 src/dpp-util.h |  4 +++
 2 files changed, 70 insertions(+), 3 deletions(-)

RFC->v1:
 * Decided to make this not configurable with an option. Any
   supplicant should support 3rd party fields existing (even
   if they don't parse them) and the two settings here will
   only improve the experience. 

diff --git a/src/dpp-util.c b/src/dpp-util.c
index cadc6437..c805b14a 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -144,6 +144,40 @@ static uint32_t dpp_parse_akm(char *akms)
 	return akm_out;
 }
 
+static bool dpp_parse_extra_options(struct dpp_configuration *config,
+					struct json_iter *extra)
+{
+	struct json_iter host_val;
+	struct json_iter hidden_val;
+	bool hostname = false;
+	bool hidden = false;
+
+	if (!json_iter_parse(extra,
+			JSON_OPTIONAL("send_hostname", JSON_PRIMITIVE,
+					&host_val),
+			JSON_OPTIONAL("hidden", JSON_PRIMITIVE, &hidden_val),
+			JSON_UNDEFINED))
+		return false;
+
+	/*
+	 * The values are optional in order to support backwards compatibility
+	 * if more are added, but if the key does exist require the type
+	 * matches and fail otherwise.
+	 */
+	if (json_iter_is_valid(&host_val) &&
+			!json_iter_get_boolean(&host_val, &hostname))
+		return false;
+
+	if (json_iter_is_valid(&hidden_val) &&
+			!json_iter_get_boolean(&hidden_val, &hidden))
+		return false;
+
+	config->send_hostname = hostname;
+	config->hidden = hidden;
+
+	return true;
+}
+
 /*
  * TODO: This handles the most basic configuration. i.e. a configuration object
  * with ssid/passphrase/akm.
@@ -156,6 +190,7 @@ struct dpp_configuration *dpp_parse_configuration_object(const char *json,
 	struct json_iter iter;
 	struct json_iter discovery;
 	struct json_iter cred;
+	struct json_iter extra;
 	_auto_(l_free) char *tech = NULL;
 	_auto_(l_free) char *ssid = NULL;
 	_auto_(l_free) char *akm = NULL;
@@ -172,6 +207,7 @@ struct dpp_configuration *dpp_parse_configuration_object(const char *json,
 			JSON_MANDATORY("wi-fi_tech", JSON_STRING, &tech),
 			JSON_MANDATORY("discovery", JSON_OBJECT, &discovery),
 			JSON_MANDATORY("cred", JSON_OBJECT, &cred),
+			JSON_OPTIONAL("/net/connman/iwd", JSON_OBJECT, &extra),
 			JSON_UNDEFINED))
 		goto free_contents;
 
@@ -210,6 +246,11 @@ struct dpp_configuration *dpp_parse_configuration_object(const char *json,
 	if (!config->akm_suites)
 		goto free_config;
 
+	if (json_iter_is_valid(&extra)) {
+		if (!dpp_parse_extra_options(config, &extra))
+			l_warn("Extra settings failed to parse!");
+	}
+
 	json_contents_free(c);
 
 	return config;
@@ -258,10 +299,20 @@ char *dpp_configuration_to_json(struct dpp_configuration *config)
 						config->psk);
 
 	return l_strdup_printf("{\"wi-fi_tech\":\"infra\","
-				"\"discovery\":{\"ssid\":\"%s\"},"
-				"\"cred\":{\"akm\":\"%s\",%s}}",
+				"\"discovery\":{"
+					"\"ssid\":\"%s\""
+				"},"
+				"\"cred\":{"
+					"\"akm\":\"%s\",%s"
+				"},"
+				"\"/net/connman/iwd\":{"
+					"\"send_hostname\":%s,"
+					"\"hidden\":%s}"
+				"}",
 				ssid, dpp_akm_to_string(config->akm_suites),
-				pass_or_psk);
+				pass_or_psk,
+				config->send_hostname ? "true" : "false",
+				config->hidden ? "true" : "false");
 }
 
 struct dpp_configuration *dpp_configuration_new(
@@ -273,6 +324,8 @@ struct dpp_configuration *dpp_configuration_new(
 	_auto_(l_free) char *passphrase = NULL;
 	_auto_(l_free) char *psk = NULL;
 	size_t ssid_len = strlen(ssid);
+	bool send_hostname;
+	bool hidden;
 
 	if (!l_settings_has_group(settings, "Security"))
 		return NULL;
@@ -299,6 +352,16 @@ struct dpp_configuration *dpp_configuration_new(
 
 	config->akm_suites = akm_suite;
 
+	if (!l_settings_get_bool(settings, "IPv4", "SendHostname",
+					&send_hostname))
+		send_hostname = false;
+
+	if (!l_settings_get_bool(settings, "Settings", "Hidden", &hidden))
+		hidden = false;
+
+	config->send_hostname = send_hostname;
+	config->hidden = hidden;
+
 	return config;
 }
 
diff --git a/src/dpp-util.h b/src/dpp-util.h
index 0724ee44..dc8a894b 100644
--- a/src/dpp-util.h
+++ b/src/dpp-util.h
@@ -117,6 +117,10 @@ struct dpp_configuration {
 	uint32_t akm_suites;
 	char *passphrase;
 	char *psk;		/* hex string */
+
+	/* "3rd party extensions" only applicable for two IWD peers */
+	bool send_hostname : 1;
+	bool hidden : 1;
 };
 
 struct dpp_configuration *dpp_parse_configuration_object(const char *json,
-- 
2.34.1

