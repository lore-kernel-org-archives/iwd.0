Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C1D2FB
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 22:58:00 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f97e08b012so20647685e9.3
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687215479; x=1689807479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EetHERUSVE/jo2x4c9w/dzXdOb9U8pYkDW98AbHEVLU=;
        b=U7JjxaF+rMlDUS6YOgIrQKFTVl16C6om/rJuOofpHgInF5W9ALAwqPjftwgpsVL1b2
         7Hd4P6tcj72CRWNSZ0OhsR6Q4xMg/ILRaDFl7ymPhgZ/KZyrnJ99BEje9nz/iFQXNZp7
         S9UXSD90h9YdAI4u0Lg45kDuiyUh3rA/oG/qGXDBu9W5p0zZCcmeSrfaaw2hs7x8cO/O
         oZ4t6BiVFhkq8gK4wMj8TXiNnFZFC1FBOAVkJxtwo/QnuVP915t1y+agPrqrEshlfTnT
         3wpx1vm3UVDUuzewQurJXETWKw0TJbLftGIMj6Gn7BDlyA01uoHZk7hlhSCO/QT3KAMV
         OfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687215479; x=1689807479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EetHERUSVE/jo2x4c9w/dzXdOb9U8pYkDW98AbHEVLU=;
        b=Fgw27Alk3xEf39X+0e1NFkXpo74QU2He/TuXgQ/CW28geBPBp8DWa+jOFIjGWlZs/r
         EE+dWWO4YNiDO5M0IAANFyQiG5SwwdhfWNLW9/+PZKu7EG7+CO/8+YcxfwEdgFfRq0VM
         pCoB0WJaZJDmwRAjRD3SVKukOa1Gtky6iR1Gjic2bkcG+dCnYoJ4bkD52lZgZbhR6PlD
         4Cews5L5Q+b7Fe1NYPBtoVyKhjlcqVg04uPGEegjwLg+OFd6QzajWlJ/qFZiMGuiCIa6
         zAn8pKLb5RgNsB+7iZaOwC7aafrxWX5ok5GCNqO8WUNQVDqIhw0v+TANcdm9ilGmhEtq
         7DKQ==
X-Gm-Message-State: AC+VfDzxYs6lMPuR9UDxs1EHA042WmPDiw8B9sxLtQU4m5PNLYKqnfFR
	4UNcPuvtwqb3lMETh7d6cTIjWYTC+ByAGg==
X-Google-Smtp-Source: ACHHUZ4OhKaob5A7qWnuGJ2laNkR+H4Ju9FqNTPYtjFHM62fvKwoER7blaoG8iVJY64vSjwxO0kSjA==
X-Received: by 2002:a5d:4a45:0:b0:30f:b9a2:92c5 with SMTP id v5-20020a5d4a45000000b0030fb9a292c5mr9238187wrs.49.1687215478228;
        Mon, 19 Jun 2023 15:57:58 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b0030c4d8930b1sm571946wrs.91.2023.06.19.15.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:57:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] eapol: use handshake_state_pmkid_matches
Date: Mon, 19 Jun 2023 15:57:44 -0700
Message-Id: <20230619225746.462791-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619225746.462791-1-prestwoj@gmail.com>
References: <20230619225746.462791-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows compatibility with older hostapd versions using the
SHA1 derivation for the FT-8021X AKM.
---
 src/eapol.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 354b8fe7..7db6148e 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1234,12 +1234,7 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 		if (!found)
 			goto error_unspecified;
 	} else if (pmkid) {
-		uint8_t own_pmkid[16];
-
-		if (!handshake_state_get_pmkid(sm->handshake, own_pmkid, false))
-			goto error_unspecified;
-
-		if (l_secure_memcmp(pmkid, own_pmkid, 16)) {
+		if (!handshake_state_pmkid_matches(sm->handshake, pmkid)) {
 			l_debug("Authenticator sent a PMKID that didn't match");
 
 			/*
-- 
2.25.1

