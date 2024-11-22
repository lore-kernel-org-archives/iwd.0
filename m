Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2861DF98C
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288572; cv=none; b=d/9zpH8Tu38mAzU8UdQD7iOGVTF9dgwrXnHhazLz0YBnge+uyESE8YO1Nzjsr2LkwYMI4wIeOHMmMMF+pSxfvCgvaOjG1etqAJbYhZDHDb/QrQ+v60/kpYWcP1ij9d/nHOb2mPejTrIyHvPWG/4koEN+T5R1S4dFT8w1O7mgpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288572; c=relaxed/simple;
	bh=app2kwmym8tp71UN5ya5RecWFQZ5ovPmS+/7ZcEHEyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZyYYK3F82TVgVoo4ekUXpQAbN/z9Cl8Jbz3ZCpSHVAdGCbPECds7q6wVjCNaOGcvNQiETcDwdfUNBMqoIgFawmhYfuGFl0iDWCUpNVPWK9JLiirKSaQNBYgT69dxUfX0AbIFT+xGcztRUair6Tw8JBCuV+/TM8kluZg0t+LCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW7bowpn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW7bowpn"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d41c87aec0so15820536d6.0
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288569; x=1732893369; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZj33h3ZSmotzU73CoGbrIL9FdQqLM+ERMw0N8q/Qto=;
        b=RW7bowpnuVb3LYkevUWCK8MS6LD4ABC6DW8cneuhGQV0dlRLVn9gfVWfghxty/y+eN
         nJS7vSddFHYQ30WT32CpxuO/6noXyggLmXp9H7y/4KuePX8BGwRlE5R7zLHufilLAwo7
         CErSYNgKJU4z3MrZr++G0xbJ5k5Zojhop9r0Q6Tn6tdQBio7fUzA1aDxNZSRMU7kp/3s
         VRc0kch3ixtElKz4H0pTunMoPersGimd94KnHAgES9PS8X6Bm0UgNBnTnTbunaZ6isFb
         Ol2ssVg3AVFZZHKvmfbAN9CFqSUinRp3WNRalqlTiUoo+2lqE86SYN3ltgYwmJq6y7zI
         wIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288569; x=1732893369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZj33h3ZSmotzU73CoGbrIL9FdQqLM+ERMw0N8q/Qto=;
        b=dKizKe8y0TM/18vHF4j2+NYjKd2E4XfkQW2dR9gDwbr/Q3HERrjQKCv5SJu9PMxDFU
         oFOi5ZCc2eS5dI+6yZLJlG3noR0uDZ2Q8W/3qlhi7+vrDyycU9r2XQZ569WKbJ94AWFC
         z1BvttVyD6orhNp4dgCBlsI+uFmLEVxe9l9oFbGy+CuDE/+eHca3Ghu+k9pvgp1gck40
         4yij+q4cvW2cV+eMgmYzAkm+YKArPa6kqaXAscftP68J+4AGcSxnE3oiUtd1FXaQ75ES
         rr/k5PZIXCQa1hJEF/ki/7s15EQ2gHTbJtIan/xf2q7rZpNcj9SrR7A1VhXTrKNLwqdO
         V0AQ==
X-Gm-Message-State: AOJu0YzqciLqLrHkxiQV/o8Om88JX2FK5ewX/wBs1xzCL+q/pPl2kQ8C
	Ujz3il1IM5cc7It6XPCDVhBAbx/cQDVRissJzY5EnX1Y8fRB1ZHGT8vrdw==
X-Gm-Gg: ASbGncvgSpFhFR/So5iO0bQSgIzVVxrVDWLp3jg/q6TGrD8teRJOCQhkf21ylP5Gh8Y
	wbvW0DbVUnjwyUoPnxXfXAcjfUnn5IKuZN1rCFAmbET0vUZrNx36txTG5RLdKwzvrtExD0MibDc
	Z6LBJokeGa/HjBy9/g2DBOv3oWyzj1xTP3lm6FDdzfz/EYWOOOEVzJjMB532i3aH46WwYbAnWJk
	AnEVKjw/xiXv3LyZWexgXSMuRGI5p4tEs3KVRGjsoGclbAPgGeEPc9ouSm/
X-Google-Smtp-Source: AGHT+IE0jxY2feoVvDdWXZhbwmL/PUkydaVdyOqHx1uItzQTo1zifZB5T8SVJmVoI8k7+hMubtc1Hg==
X-Received: by 2002:a05:6214:528f:b0:6d4:2267:61c2 with SMTP id 6a1803df08f44-6d450eccbb3mr47274176d6.15.1732288569161;
        Fri, 22 Nov 2024 07:16:09 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>,
	James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/15] handshake: Add pmksa setter & stealer
Date: Fri, 22 Nov 2024 07:15:45 -0800
Message-Id: <20241122151551.286355-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denkenz@gmail.com>

The majority of this patch was authored by Denis Kenzior, but
I have appended setting the PMK inside handshake_state_set_pmksa
as well as checking if the pmkid exists in
handshake_state_steal_pmkid.

Authored-by: Denis Kenzior <denkenz@gmail.com>
Authored-by: James Prestwood <prestwoj@gmail.com>
---
 Makefile.am     |  4 +++
 src/handshake.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/handshake.h | 11 ++++++-
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 598b8f90..89198289 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -458,6 +458,7 @@ unit_test_eap_sim_SOURCES = unit/test-eap-sim.c \
 		src/eapol.h src/eapol.c \
 		src/eapolutil.h src/eapolutil.c \
 		src/handshake.h src/handshake.c \
+		src/pmksa.h src/pmksa.c \
 		src/eap.h src/eap.c src/eap-private.h \
 		src/util.h src/util.c \
 		src/simauth.h src/simauth.c \
@@ -517,6 +518,7 @@ unit_test_eapol_SOURCES = unit/test-eapol.c \
 				src/eapol.h src/eapol.c \
 				src/eapolutil.h src/eapolutil.c \
 				src/handshake.h src/handshake.c \
+				src/pmksa.h src/pmksa.c \
 				src/eap.h src/eap.c src/eap-private.h \
 				src/eap-tls.c src/eap-ttls.c \
 				src/eap-md5.c src/util.c \
@@ -547,6 +549,7 @@ unit_test_wsc_SOURCES = unit/test-wsc.c src/wscutil.h src/wscutil.c \
 				src/eapol.h src/eapol.c \
 				src/eapolutil.h src/eapolutil.c \
 				src/handshake.h src/handshake.c \
+				src/pmksa.h src/pmksa.c \
 				src/eap.h src/eap.c src/eap-private.h \
 				src/util.h src/util.c \
 				src/erp.h src/erp.c \
@@ -565,6 +568,7 @@ unit_test_sae_SOURCES = unit/test-sae.c \
 				src/crypto.h src/crypto.c \
 				src/ie.h src/ie.c \
 				src/handshake.h src/handshake.c \
+				src/pmksa.h src/pmksa.c \
 				src/erp.h src/erp.c \
 				src/band.h src/band.c \
 				src/util.h src/util.c \
diff --git a/src/handshake.c b/src/handshake.c
index 7fb75dc4..a93143d1 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -43,6 +43,7 @@
 #include "src/handshake.h"
 #include "src/erp.h"
 #include "src/band.h"
+#include "src/pmksa.h"
 
 static inline unsigned int n_ecc_groups(void)
 {
@@ -138,6 +139,9 @@ void handshake_state_unref(struct handshake_state *s)
 	l_free(s->fils_ip_resp_ie);
 	l_free(s->vendor_ies);
 
+	if (s->have_pmksa)
+		l_free(s->pmksa);
+
 	if (s->erp_cache)
 		erp_cache_put(s->erp_cache);
 
@@ -701,6 +705,11 @@ void handshake_state_install_ptk(struct handshake_state *s)
 {
 	s->ptk_complete = true;
 
+	if (!s->have_pmksa && IE_AKM_IS_SAE(s->akm_suite)) {
+		l_debug("Adding PMKSA expiration");
+		s->expiration = l_time_now() + pmksa_lifetime();
+	}
+
 	if (install_tk) {
 		uint32_t cipher = ie_rsn_cipher_suite_to_cipher(
 							s->pairwise_cipher);
@@ -1203,3 +1212,71 @@ done:
 
 	return r;
 }
+
+bool handshake_state_set_pmksa(struct handshake_state *s,
+					struct pmksa *pmksa)
+{
+	/* checks for both expiration || pmksa being set */
+	if (s->expiration)
+		return false;
+
+	s->pmksa = pmksa;
+	s->have_pmksa = true;
+
+	handshake_state_set_pmkid(s, pmksa->pmkid);
+	handshake_state_set_pmk(s, pmksa->pmk, pmksa->pmk_len);
+
+	return true;
+}
+
+static struct pmksa *handshake_state_steal_pmksa(struct handshake_state *s)
+{
+	struct pmksa *pmksa;
+	uint64_t now = l_time_now();
+
+	if (s->have_pmksa) {
+		pmksa = l_steal_ptr(s->pmksa);
+		s->have_pmksa = false;
+
+		if (l_time_after(now, pmksa->expiration)) {
+			l_free(pmksa);
+			pmksa = NULL;
+		}
+
+		return pmksa;
+	}
+
+	if (s->expiration && l_time_after(now, s->expiration)) {
+		s->expiration = 0;
+		return NULL;
+	}
+
+	if (!s->have_pmkid)
+		return NULL;
+
+	pmksa = l_new(struct pmksa, 1);
+	pmksa->expiration = s->expiration;
+	memcpy(pmksa->spa, s->spa, sizeof(s->spa));
+	memcpy(pmksa->aa, s->aa, sizeof(s->aa));
+	memcpy(pmksa->ssid, s->ssid, s->ssid_len);
+	pmksa->ssid_len = s->ssid_len;
+	pmksa->akm = s->akm_suite;
+	memcpy(pmksa->pmkid, s->pmkid, sizeof(s->pmkid));
+	pmksa->pmk_len = s->pmk_len;
+	memcpy(pmksa->pmk, s->pmk, s->pmk_len);
+
+	return pmksa;
+}
+
+void handshake_state_cache_pmksa(struct handshake_state *s)
+{
+	struct pmksa *pmksa = handshake_state_steal_pmksa(s);
+
+	l_debug("%p", pmksa);
+
+	if (!pmksa)
+		return;
+
+	if (L_WARN_ON(pmksa_cache_put(pmksa) < 0))
+		l_free(pmksa);
+}
diff --git a/src/handshake.h b/src/handshake.h
index 6c0946d4..cf7dc48c 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -29,6 +29,7 @@
 struct handshake_state;
 enum crypto_cipher;
 struct eapol_frame;
+struct pmksa;
 
 enum handshake_kde {
 	/* 802.11-2020 Table 12-9 in section 12.7.2 */
@@ -141,7 +142,12 @@ struct handshake_state {
 	bool supplicant_ocvc : 1;
 	bool ext_key_id_capable : 1;
 	bool force_default_ecc_group : 1;
-	uint8_t ssid[SSID_MAX_SIZE];
+	bool have_pmksa : 1;
+	union {
+		struct pmksa *pmksa;
+		uint64_t expiration;
+	};
+	uint8_t ssid[32];
 	size_t ssid_len;
 	char *passphrase;
 	char *password_identifier;
@@ -302,6 +308,9 @@ void handshake_state_set_chandef(struct handshake_state *s,
 int handshake_state_verify_oci(struct handshake_state *s, const uint8_t *oci,
 				size_t oci_len);
 
+bool handshake_state_set_pmksa(struct handshake_state *s, struct pmksa *pmksa);
+void handshake_state_cache_pmksa(struct handshake_state *s);
+
 bool handshake_util_ap_ie_matches(const struct ie_rsn_info *msg_info,
 					const uint8_t *scan_ie, bool is_wpa);
 
-- 
2.34.1

