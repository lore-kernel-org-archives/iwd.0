Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00193D88
	for <iwd@lists.linux.dev>; Mon,  8 Aug 2022 17:14:12 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id r22so6724878pgm.5
        for <iwd@lists.linux.dev>; Mon, 08 Aug 2022 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Yq7eTnTHZKeOLbA2X8+EU/IZyNMTpolPM9o1DWQMPbg=;
        b=bedcVmInVW6RwJnqGW3s0aeQOc0mQWWKll/v0LXnT1OvMa0Ynflgh5nuCNcUbNOdS9
         wae16XYis5UJ40COXzaJwaYIIiJt2NRw1uAp0Rb2bugFE3epO5ismi/CKc8DSASXQmtc
         2j/Gu60qCv4JpLUQ+YFHiBg9zdlRAyp4vV6GVgW6hS4KSgiyENVUmaGAaqzuSDxJ263z
         55THyaVp/1R8EiVVv9dkFa+oIR3iBR++3+XxtnYuaTUEdk+w5YSwzpVAD0c2s59BZDUY
         7oQtFR7V0RA52nAkA1z1rqmKMZbzFtVjONCp6rPFdZ29GPKeMcjCvpcgB2k4XKJ+tHBI
         kZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Yq7eTnTHZKeOLbA2X8+EU/IZyNMTpolPM9o1DWQMPbg=;
        b=LNTsdcJvE0dI9TVjFTjYHi01x7FgU4NPJOodIz9oaka3uz1vWLW3MA/qhXCtAMRfsC
         irRJihv7N4Do+LqEcuG/0fozwqpgGN/BgJWFPyPo01MY7SjqLgzLFyYiX50C5S5aJD+f
         V27sSvpg+tkuekzzm7U+bfhym+DkYyFbWNrMOx+ZE+r2sly6sH6Lhg8+KMjSzC6OGmI3
         2BUfBihOIlrYvVsEUy4fsUJbnH8D/GncSlY7yFwSXO4dblKareCHENNKLihtvkOc3owv
         lAbaHrma+dQj+IjCa0fMOcpjilowIb5fsS6pAjQOqXya4W9/6N/DC1+Y+0B4o7o0v1pW
         D/oQ==
X-Gm-Message-State: ACgBeo0jYmipL928VgZAse1YGRVHkkhuMI1DFbxxhNTE9M8UW9Yuhfp6
	aZexPzD4qcMo93+oVBsneRSEIPbEVw0=
X-Google-Smtp-Source: AA6agR5gN03ccrtMBGRvwnXEP0N4RfKW6QjcQpqrbx9YeA8ADkMuXQ4v/undPijhh7fiIwcIWlaxVQ==
X-Received: by 2002:a65:6b96:0:b0:41a:617f:e193 with SMTP id d22-20020a656b96000000b0041a617fe193mr16147369pgw.85.1659978852006;
        Mon, 08 Aug 2022 10:14:12 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b0016dd667d511sm8932754plk.252.2022.08.08.10.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:14:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] station: re-try OWE if buggy AP is detected
Date: Mon,  8 Aug 2022 10:14:06 -0700
Message-Id: <20220808171406.12931-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220808171406.12931-1-prestwoj@gmail.com>
References: <20220808171406.12931-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some APs use an older hostapd OWE implementation which incorrectly
derives the PTK. To work around this group 19 should be used for
these APs. If there is a failure (reason=2) and the AKM is OWE
set force default group into network and retry. If this has been
done already the behavior is no different and the BSS will be
blacklisted.
---
 src/station.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index c5dfc48e..40f9848f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2815,6 +2815,31 @@ static bool station_try_next_bss(struct station *station)
 	return true;
 }
 
+static bool station_retry_owe_default_group(struct station *station)
+{
+	const uint8_t *rsne = station->connected_bss->rsne;
+	struct ie_rsn_info info;
+
+	if (!rsne)
+		return false;
+
+	if (ie_parse_rsne_from_data(rsne, rsne[1] + 2, &info))
+		return false;
+
+	if (!(info.akm_suites & IE_RSN_AKM_SUITE_OWE))
+		return false;
+
+	/* If we already forced group 19, allow the BSS to be blacklisted */
+	if (network_get_force_default_owe_group(station->connected_network))
+		return false;
+
+	l_debug("Buggy OWE AP detected, retrying by forcing group 19!");
+
+	network_set_force_default_owe_group(station->connected_network);
+
+	return true;
+}
+
 static bool station_retry_with_reason(struct station *station,
 					uint16_t reason_code)
 {
@@ -2825,12 +2850,20 @@ static bool station_retry_with_reason(struct station *station,
 	 * Other reason codes can be added here if its decided we want to
 	 * fail in those cases.
 	 */
-	if (reason_code == MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID ||
-			reason_code == MMPDU_REASON_CODE_IEEE8021X_FAILED)
+	switch (reason_code) {
+	case MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID:
+		if (station_retry_owe_default_group(station))
+			goto try_next;
+		/* fall through */
+	case MMPDU_REASON_CODE_IEEE8021X_FAILED:
 		return false;
+	default:
+		break;
+	}
 
 	blacklist_add_bss(station->connected_bss->addr);
 
+try_next:
 	return station_try_next_bss(station);
 }
 
-- 
2.34.3

