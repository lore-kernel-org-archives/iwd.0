Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C305F1F8
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ9IPJ1Z"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67adc37b797so5119206d6.1
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791217; x=1702396017; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbIAX+OX886LW7j5nKIosUWE7irYaEIenybfS3otCjk=;
        b=WZ9IPJ1ZLJYatM0p4uQi2FXewkOElBz/ngOrdusxB/5APBUJ8zAhxWLq/s5HQ0OQNe
         fOG1xqF61jlStCveAU2RRuVVxY3J+E3K83TZbse/5plkkKL3X9FyaOK2T9Eymz5OP8k9
         MVzwNeqe33y3CxuOJr/qZZI7ytAIONgibAEd8YQK0W1g3dTVHlcOIzIpe5AQUJBP4Wvp
         Khlsr04CNqtlNzp+CVa/LUM4c8ee7zz4Qs3ZZSLNN5QpwOoWR2P2OWmq0p6x1N752WuT
         /LivbzURPnR8CJuU8j3FXz7HsxdAPg5UnNvglL6ecq4j6S61Hky84woNQZiXu4EzUQci
         TlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791217; x=1702396017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbIAX+OX886LW7j5nKIosUWE7irYaEIenybfS3otCjk=;
        b=l8AhDslKMh1XVarXWJuh7Ld2QlXvAfxUclSZaB0g2p+7ZgF/UN6Fl6cesLuqokmpkN
         HOj0qp1Lnccu743hDKLnY/F4JdoZZD8sDd/bicFSbxCJLAuJPCRpy4Lv/vmRn7299FyA
         Rd3GMKCqmarsyiVRp83T7TVoZxehAooECBIkC9j+LJNSlpQVecEL8IDqqat0O5fSuBcP
         bM9LXGy0LDhyplPbEz+fl+mNEPlxdfkaBjh8p3pE8XBa5pBW0bvOLi2yziqijjebVU06
         DsdoHVVR6iI396agAEMmWH13YiEPw912iOU6atpPtO20FletOvppEXSId+ToTam6Mq8T
         /Ozg==
X-Gm-Message-State: AOJu0YyBP3eO7n0uGlENV+DWzd/K95V9A2juFKvyNSLN7hB7pZQ3LqJX
	OnOzRmNIDgDUb86/HvWTZG8ErJWyV0o=
X-Google-Smtp-Source: AGHT+IHQQVYFWHDlUpoe7jQHKIZ0p+Czo0Bg5kNl67K3GbxX0CoUrqsnPVX6SktFpfkFQrKA0XSDbQ==
X-Received: by 2002:a05:6214:ca8:b0:67a:d693:e2d7 with SMTP id s8-20020a0562140ca800b0067ad693e2d7mr1968515qvs.11.1701791216730;
        Tue, 05 Dec 2023 07:46:56 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:46:56 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/10] handshake: add password identifier/setter
Date: Tue,  5 Dec 2023 07:46:40 -0800
Message-Id: <20231205154647.1778389-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205154647.1778389-1-prestwoj@gmail.com>
References: <20231205154647.1778389-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/handshake.c | 12 ++++++++++++
 src/handshake.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/src/handshake.c b/src/handshake.c
index 1c5ed2c9..cf9c18d5 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -137,6 +137,12 @@ void handshake_state_free(struct handshake_state *s)
 		l_free(s->passphrase);
 	}
 
+	if (s->password_identifier) {
+		explicit_bzero(s->password_identifier,
+				strlen(s->password_identifier));
+		l_free(s->password_identifier);
+	}
+
 	if (s->ecc_sae_pts) {
 		unsigned int i;
 
@@ -364,6 +370,12 @@ void handshake_state_set_passphrase(struct handshake_state *s,
 	s->passphrase = l_strdup(passphrase);
 }
 
+void handshake_state_set_password_identifier(struct handshake_state *s,
+						const char *id)
+{
+	s->password_identifier = l_strdup(id);
+}
+
 void handshake_state_set_no_rekey(struct handshake_state *s, bool no_rekey)
 {
 	s->no_rekey = no_rekey;
diff --git a/src/handshake.h b/src/handshake.h
index 815eb44f..3b51cb34 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -143,6 +143,7 @@ struct handshake_state {
 	uint8_t ssid[32];
 	size_t ssid_len;
 	char *passphrase;
+	char *password_identifier;
 	uint8_t r0khid[48];
 	size_t r0khid_len;
 	uint8_t r1khid[6];
@@ -228,6 +229,8 @@ void handshake_state_set_event_func(struct handshake_state *s,
 					void *user_data);
 void handshake_state_set_passphrase(struct handshake_state *s,
 					const char *passphrase);
+void handshake_state_set_password_identifier(struct handshake_state *s,
+						const char *id);
 bool handshake_state_add_ecc_sae_pt(struct handshake_state *s,
 					const struct l_ecc_point *pt);
 void handshake_state_set_no_rekey(struct handshake_state *s, bool no_rekey);
-- 
2.34.1

