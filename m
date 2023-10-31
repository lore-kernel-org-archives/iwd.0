Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C21DFE0
	for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aeb2ctLH"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5afabb23900so49534217b3.2
        for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 11:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778082; x=1699382882; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1THlJ04vIb0fySHMf9Vww6qxLSn99GPGcL4C1Oqq6b0=;
        b=Aeb2ctLHdWSAqFUKGCmk1KuLM8n794aky4tbp4qZ7E5cKWpDjVTq3VdnXAvYrjDTmA
         ScEXQKqiytmax6e3Sqz79aGdyN21oIKpHS/q1QR6krDq3xS3hgR+YwE9aRYkTUcJZ0j6
         S/59zKzt5JpzMuZpopTczLfepKhxip2ENPIrOawPKLrAhE2QjhZkpShUhIx7pSG2aLWz
         qoJRSpXQg1WdGL+QS5uLUO3E5q3b0khp7bdYPKpWD2jZAaYHzFKB96NLe06YqSf38dcj
         sodN5q4zvzmhyuqmnN6+AMIV3QXOmiFY5NN2aHGIX6KQfFFObdtrc3VKqrbJxZY9wtTG
         1MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778082; x=1699382882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1THlJ04vIb0fySHMf9Vww6qxLSn99GPGcL4C1Oqq6b0=;
        b=wtNYwWf311loGx3+f9f59kxxvNkmUq8cG8/DOsJjTe8VS8LKG+YUdOEI5xYb+aj6Pc
         9vsdb4QsJFdp2ndJLcURJjcjGXkj5cP8aFcJx6Nej0rS98Mk8wf/JBik85crSvW1e9hx
         4Ex2yFsFJCbwLdfVnbL+6OeMcnQSK1KjUFT3cv2fnukph710aM5VO3d4LGxzc1CLUVy4
         vgbaYJr0pBCQdCWeo6yTS3NpfbWjGHTsXxAwZQHMuvox8PXE+lmB7CZiDcHCoF9fV2KQ
         xPfRkL/W8wadCe7TYDwj6ttRX0GAjGKde6dtuovyCY7oipVZ8NQV44o9aXAyo+tiZdhg
         ki/g==
X-Gm-Message-State: AOJu0YzYpPV3NH2OkH5vWeoHISH2Wi3bhCT+98uL+8kHx3K/WR4fyMnG
	f6cV27mjSgBgJJGd7jk8P9A4TyDqX9s=
X-Google-Smtp-Source: AGHT+IHJhWznI8ZlpT3TaCzCSSTnDVXIb38ARew5fMtor3eqRgCf2FFDQXGRZwKm0MphzWB0S+s6uQ==
X-Received: by 2002:a81:4f90:0:b0:59f:5361:d18c with SMTP id d138-20020a814f90000000b0059f5361d18cmr15308817ywb.41.1698778081893;
        Tue, 31 Oct 2023 11:48:01 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00774292e636dsm736351qkb.63.2023.10.31.11.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:48:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/9] dpp: allow enrollee to be authentication initiator
Date: Tue, 31 Oct 2023 11:47:44 -0700
Message-Id: <20231031184750.722404-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184750.722404-1-prestwoj@gmail.com>
References: <20231031184750.722404-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now IWD only supported enrollees as responders (configurators
could do both). For PKEX it makes sense for the enrollee to be the
initiator because configurators in the area are already on their
operating channel and going off is inefficient. For PKEX, whoever
initiates also initiates authentication so for this reason the
authentication path is being opened up to allow enrollees to
initiate.
---
 src/dpp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index dcf5953f..e5e1b3fa 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1468,7 +1468,7 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 	struct scan_bss *bss = station_get_connected_bss(station);
 
 	/* Got disconnected by the time the peer was discovered */
-	if (!bss) {
+	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR && !bss) {
 		dpp_reset(dpp);
 		return false;
 	}
@@ -1489,7 +1489,8 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 				i_proto_key, dpp->key_len * 2);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
 
-	if (dpp->current_freq != bss->frequency) {
+	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR &&
+					dpp->current_freq != bss->frequency) {
 		uint8_t pair[2] = { 81,
 				band_freq_to_channel(bss->frequency, NULL) };
 
@@ -1926,9 +1927,6 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	if (dpp->state != DPP_STATE_AUTHENTICATING)
 		return;
 
-	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
-		return;
-
 	if (!dpp->freqs)
 		return;
 
@@ -2082,6 +2080,10 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	dpp->current_freq = dpp->new_freq;
 
 	dpp_send_authenticate_confirm(dpp);
+
+	if (dpp->role == DPP_CAPABILITY_ENROLLEE)
+		dpp_configuration_start(dpp, from);
+
 }
 
 static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
-- 
2.25.1

