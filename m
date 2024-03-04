Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC61E487
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570938; cv=none; b=pPyrIJIKWLgpXxBYeo4+5MbuSJSi12PRdORGny5wImeOuYQX78mehvtoahMdyhOUtbc3RXIppCEWM43ijYQnMAJNFzvoIiEnC1GgpMmtp/1hTgSrygfhbqMP0yXognNZWG4CNgJiWbJcfLrsipXH4LNwelf6WnoSLglQ3pmLp7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570938; c=relaxed/simple;
	bh=WPk6C1WQKKhbC/aSnDJhUxOCr/Yc+AE5hYHG6HWAPyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arJCo0+ExkVYqtx/8UttjRH61qvb/yai9rbuo6g1hqBsjhx2JJJeNy2EH3nSzNEpSaKu0pYeQHVInMIjss42a9j/See72xjM528IuyTtyX3Q4Kk2jc/iXvXhCK1oENQ0/RMTU3jO9ql1j3C02uRlS48O15GkfZeuV05DGY/UQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSRz08+F; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSRz08+F"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68ffddd89d1so17719406d6.0
        for <iwd@lists.linux.dev>; Mon, 04 Mar 2024 08:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709570936; x=1710175736; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNLrofK26lIEsZuiCmRsSvu92wvxeyXHsAzSraLT2rk=;
        b=hSRz08+FsHBq8AuZ5KDixUxKwiuAfFS47KpollJ6bCnqYDo0eejER0rIM6Azgfn50z
         nCLP913+SDBrsVdZIgAq8Pfi49Go1tUJd87WPvmpX9SYN555EyPsmzaYe3QkGnDk8w4+
         EwXOdCsLIUd1UCido9ZbzovYIjQayTa1N9vwezI+cvSFPFWtZDLPx605bA0adsy80370
         8SGri3VQ0tAdzkKFtYNGkiyVgRezb6QTtCYn7QSOmOMmgTpIesgZgSFxe2TbGricmj4g
         ed6fb8FPXW2EnMBXZeqKvZaI/Ky64ooqKTeIE5s/l77eFJaACm3D/uor1A1nPfMHAiUN
         aLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570936; x=1710175736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNLrofK26lIEsZuiCmRsSvu92wvxeyXHsAzSraLT2rk=;
        b=iSStdujPmOvlvpT0jR3sniLB5Ucu5rpzWSZaAXzBsdd/cplB4ao4CsQCLHkZKnDRmz
         3oRtNJspRSk4pu8xNENNEqRbGSmdJ8cvdGpgmszS8wkiAF6qhLWILpTp+o6p/jzrlSYe
         fBNgVmeJqfV3IWql8Fdacbf1WQllmtRNaIXai178MeSKsAA7iDZSKEib/Y299F8c6R23
         i/VszX940ImljcT27E/VI0ajmzRuRiAc0T1IzAIxYHsGhE3AtWTfYqi0pxRdC29G0y3z
         iHfiFQn9xyHa4UPqPR5FdVoZNNljMIPn2UePk8aKV4tb/X58+pd/6vcMhyGoBki5D/Pa
         GeHQ==
X-Gm-Message-State: AOJu0YwS8lusDfm6aL5P5oNZtu3Lwwkr9uDqDwBG1tX6m0Fk7LHn2oPd
	aC+EuPbUXVy3VVpiddSGftxgPM5ui8oqn/mtmcF9YU71MjXyhmfovlO3p/w3
X-Google-Smtp-Source: AGHT+IEICwi3R4MVA9CYcch3PdMPWuk5EXeOG4VlwQH15r8w9TbrXXGXiAdPTigwj1KSgK5dIx5dtQ==
X-Received: by 2002:a0c:bf09:0:b0:68f:6f92:d291 with SMTP id m9-20020a0cbf09000000b0068f6f92d291mr10356457qvi.4.1709570935946;
        Mon, 04 Mar 2024 08:48:55 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id qq1-20020a0562142c0100b0068fdc55ec7dsm3858466qvb.68.2024.03.04.08.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:48:55 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] files: remove unneeded initialization
Date: Mon,  4 Mar 2024 08:48:44 -0800
Message-Id: <20240304164846.1783148-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304164846.1783148-1-prestwoj@gmail.com>
References: <20240304164846.1783148-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/fils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/fils.c b/src/fils.c
index f876e7e5..ff8c1d6c 100644
--- a/src/fils.c
+++ b/src/fils.c
@@ -489,7 +489,7 @@ static int fils_rx_associate(struct auth_proto *driver, const uint8_t *frame,
 	bool sha384 = (fils->hs->akm_suite & (IE_RSN_AKM_SUITE_FILS_SHA384 |
 			IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384));
 	uint8_t data[44];
-	uint8_t *ptr = data;
+	uint8_t *ptr;
 
 	if (assoc->status_code != 0)
 		return L_CPU_TO_LE16(assoc->status_code);
-- 
2.34.1

