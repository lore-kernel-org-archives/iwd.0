Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA664A17
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:25:35 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id l64so10144109pge.0
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pa4GC/P96VOsciYaIlI8AloeE9SNoyviro8BNZobB4k=;
        b=CXXNSMPaA1UnqqhppfNtlay0ziIvidw818VavtSzWMjCEUv3dishRkBjWohyiGbMLp
         XCJeuKZXv54bZ7digE10J4PuefiGhNL7EuyqdtrBH61BXnvgFrLSJ6qqDMTHFZr+qpNB
         t5/VxOgxRWM7Q8DAPH675m/L48Mh6l4Ymk6rDxRUSwzuGip9ZWjEZ4eTN/bqrIKztW0+
         FI3cFp45/jF+vec2h1g8zOot/qKtR9PopaX48uNCLhAx+difpaVHQdY2L74qikT8zm3q
         5VC2uomgAoJDjLHEVo4imVVHWyOdWhlG4cC9X/3wI4WzAeXar4dR0JFbG8Jj4zQqHo84
         tAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pa4GC/P96VOsciYaIlI8AloeE9SNoyviro8BNZobB4k=;
        b=lFWLrazBSyzM5eIQNRkLHzW5dMEQK+ERP/K/ruu5SPXtQZd/uNSS/64uuHS6ygg003
         h0RTkCMKqMPHVzyrOstj52aS52pdtT/0UKBWzWfNGbqUO5iZ0osDdTUzUUMroSy1PeNy
         4Svjw6/RagQkFfDMK+LuUrqmJBPdmIE/uV/OWW+tmIoCBv0Z2SSjw4uDLINWTvKDrTgO
         wtwtX7HN/08nzDuw3mF79qtFSRYM9vnyFABIWvVKJjGP8vqU0gZiFH0v7Y36W1wIqpKg
         Mpcz6oguFQM7wrpJJ1v4UmpfCfWLq2aL/n4LWML/A0CU2Zd/M+QR7imUghurgGigI6zZ
         +Suw==
X-Gm-Message-State: ACgBeo31cv+UTghJwTbBFpQ/BqN40hY5RSg0bI6DCltm+jw4SzZGzw6+
	KNjrtdydvsq3JTuJlJuK4lyPaqQQ+L4=
X-Google-Smtp-Source: AA6agR5sTe2X0xwnNGCc2YjlkDX6Hvn3GjqAfFZOeSjBt7x9rl5MbmWMciQmTHjnR4SuZsdiUf4V3Q==
X-Received: by 2002:aa7:81d1:0:b0:535:c2e5:eccf with SMTP id c17-20020aa781d1000000b00535c2e5eccfmr21797515pfn.16.1661192734914;
        Mon, 22 Aug 2022 11:25:34 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00172bd4c12b2sm1612024plk.224.2022.08.22.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/9] ft: expose ft_parse_authentication_resp_frame
Date: Mon, 22 Aug 2022 11:25:21 -0700
Message-Id: <20220822182525.2078312-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822182525.2078312-1-prestwoj@gmail.com>
References: <20220822182525.2078312-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be needed by netdev when doing authentication off-channel.
---
 src/ft.c | 2 +-
 src/ft.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/ft.c b/src/ft.c
index 04ae2775..84873fbd 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -116,7 +116,7 @@ static bool ft_calculate_fte_mic(struct handshake_state *hs, uint8_t seq_num,
  * the start of the IE array (RSN, MD, FT, TI and RIC).
  * See 8.3.3.1 for the header and 8.3.3.11 for the body format.
  */
-static bool ft_parse_authentication_resp_frame(const uint8_t *data, size_t len,
+bool ft_parse_authentication_resp_frame(const uint8_t *data, size_t len,
 				const uint8_t *addr1, const uint8_t *addr2,
 				const uint8_t *addr3, uint16_t auth_seq,
 				uint16_t *out_status, const uint8_t **out_ies,
diff --git a/src/ft.h b/src/ft.h
index 8bb31b28..7ae925a3 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -52,6 +52,11 @@ int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
 					const uint8_t **aa_out,
 					const uint8_t **ies_out,
 					size_t *ies_len);
+bool ft_parse_authentication_resp_frame(const uint8_t *data, size_t len,
+				const uint8_t *addr1, const uint8_t *addr2,
+				const uint8_t *addr3, uint16_t auth_seq,
+				uint16_t *out_status, const uint8_t **out_ies,
+				size_t *out_ies_len);
 bool ft_parse_ies(struct ft_info *info, struct handshake_state *hs,
 			const uint8_t *ies, size_t ies_len);
 
-- 
2.34.3

