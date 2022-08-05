Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6E2573
	for <iwd@lists.linux.dev>; Fri,  5 Aug 2022 18:20:35 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id x23so3309811pll.7
        for <iwd@lists.linux.dev>; Fri, 05 Aug 2022 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=J/dUbknHu+bVYOnxUzACsTLKfh+lZqAI9SHiUsEIH30=;
        b=J3eOL/P4qb4qG037HJLfMLEcTdZn0SqbBS43yuDl/tlWNs+prREygZXxoOAKaPbvI7
         inShVzG01gKHtTtXdouQd0S35lo19yvifuEHP3GbQUMVJRmnShTKk6owSZit+HZ0gpe9
         4+04YrJRerI0KFoZmJwIT6f6lJX2JxMTDYs2RvThjiSnPoX45/VGSRx5xE3sFDXTpdl+
         sq6NmnXCbmPDYOOnijJmJTqAjMzO6bpl9rMcJZq1uJqVIFm8TInYdDSnxbSUwrkht1P/
         puTAnHI7AsPfpVUjsqQgFLyJs15EOglIbLRVjtVtwUFeVASrJ4imT/xutldVjJ7r3FVl
         Bssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=J/dUbknHu+bVYOnxUzACsTLKfh+lZqAI9SHiUsEIH30=;
        b=n0qKjzcLCxbxzG2oOnWq2w9kScYN49XbULO2tvoczlzMX/o9epld8Fg94Z0kjUnSHw
         36au62/L4JAVn3VONbjfI2p7GsudPpA4AM3hwdfGqD/NUjSgR3bhCCSp8Q3oTSQ6bGnF
         cMnE2jtND0Vs2ge+YOLvqLZR+g3XHe8wx/9zU1Cl+OqCoO/P8NITR67nSWo13qNRQ1Mc
         iOfH18mQmyOS++J8UbiIlgVrLJmUuWOSlba3aVumeH26ZigpZvGOVu+4PSia05dBChvA
         +v6e/plxyPlItAy0SpivwqQbw0AW2MLhDI1gKGf8yo9657CXAjK4+MYp21jgzzI3vxsW
         vbeA==
X-Gm-Message-State: ACgBeo0QWzbNWrPqtJEHEZsI2hP1JkudpoCIcwXvuQQROsRDjVqdV/5G
	Y1fjOl/Haqp0cUN/1kda7qbhlPI7MhM=
X-Google-Smtp-Source: AA6agR7W/FsQ/tcFyzAgCU7KFkFCEjsE45Jnaq/HaxBsdQ8l15cE2x/R6Qc4FHDkoRFZUkPz7X1zvg==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr17648616pjb.164.1659723634961;
        Fri, 05 Aug 2022 11:20:34 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b0016d1b708729sm3409871plr.132.2022.08.05.11.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:20:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] eapol: use OWE workaround after two ignored 2/4 messages
Date: Fri,  5 Aug 2022 11:20:31 -0700
Message-Id: <20220805182031.651456-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220805182031.651456-1-prestwoj@gmail.com>
References: <20220805182031.651456-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the AP has rejected two 2/4 messages when using OWE assume its buggy
and re-dervive the PTK in a way that it (hopefully) expects.
---
 src/eapol.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/eapol.c b/src/eapol.c
index e8bd5cdb..a393e1b8 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1161,6 +1161,25 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 		return;
 	}
 
+	/*
+	 * Work around buggy OWE APs. Early hostapd implementations for OWE
+	 * incorrectly used SHA256 for the PTK derivation even in groups 20 and
+	 * 21 (should be SHA384/512). If we've already sent two 2/4 messages
+	 * without a response and the AKM is OWE assume this workaround is
+	 * needed and re-derive the PTK.
+	 *
+	 * TODO: This could be improved by checking if 2/4 was ACK'ed. If not
+	 *       this could just be a lost packet.
+	 */
+	if (sm->frame_retry >= 2 &&
+			sm->handshake->akm_suite == IE_RSN_AKM_SUITE_OWE &&
+			!sm->handshake->retry_owe_workaround) {
+		sm->handshake->retry_owe_workaround = true;
+
+		if (!handshake_state_derive_ptk(sm->handshake))
+			goto error_unspecified;
+	}
+
 	pmkid = handshake_util_find_pmkid_kde(EAPOL_KEY_DATA(ek, sm->mic_len),
 					EAPOL_KEY_DATA_LEN(ek, sm->mic_len));
 
@@ -1336,6 +1355,8 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 	l_timeout_remove(sm->eapol_start_timeout);
 	sm->eapol_start_timeout = NULL;
 
+	sm->frame_retry++;
+
 	return;
 
 error_unspecified:
-- 
2.34.3

