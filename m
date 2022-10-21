Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2236127
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:48 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id y72so4308249oia.3
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y/A/GlJkNBvJym4h19T9hvt3iF8NBWeraLeRqbLf+4=;
        b=fsxiNfEV5Glo8j6ax31W0R+c/psrpnoNOgsoBqEArbYPubMHVv68fU5XftrQ5HAX2a
         exJ5bECjAqA+Fn0ExHaan04DF3ANRAwQBonu/WztEsENqvIAmgg0eSCN6aMu3SI0ftNW
         HooE86JVrI76Ci+amTAt7cTtUfAqIu+TDrTKdpxpxvugAHQURhAHIrw1dP4NaN0Rb/gb
         ooD/uCd2Q1M+l2H449T8zzfeajJ2jYqQyV+neW+iaPGu/bi5tltImCtDZP3rpu63QRoB
         0F6JV/IRtv25Zgf4gW0Qq8Ahjjm6yCcBJT4tJyvQnkfW1khx9O0kuSbNewE4pWxxJT4+
         NYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8y/A/GlJkNBvJym4h19T9hvt3iF8NBWeraLeRqbLf+4=;
        b=Xx62mvbQdKuHtJc7gzIGfIUF054F1xrIt6SepBY8SdPT/qV2yPtxBafyRStMmAvaqo
         UkJFU/vpfELFztdVI7y2zP8EQkomZQYlk+j64QofQn6KTyCLFybEJ5iCLtiHwqFAwTJ1
         HCkKtx5GipjlDy9n+YzYnp/MQRpRcQjsLiGzARRfsrxwh1sH41pV56qRa7bM59/4XWzc
         FvA/HAR5qN+GGT8HrKD9AKKoY1NU6/EzEp8C/Y8Trwj+tG/DeFjXxFNn0t4xKgo307Ao
         v1zcIogScDiis2u0MdzkNsxhaAUo3mbPtq6Fr6PLauOGxYU027zytaaNn53TU4NEY+I1
         nImg==
X-Gm-Message-State: ACrzQf0CqtPaWLhRct3n5Dk+t19ApyFC+C++VSm3VLmHBRQhgE7r+tKW
	nKRnzOjrBFyCR4zHRij/bUiaad577a4=
X-Google-Smtp-Source: AMsMyM4/cErNKX8cEFFiOi2HQMQXCFNVzebAvl8lsMVPifSKo9AmN/Gz1a4mky1JZdAo0nHf8eRPZw==
X-Received: by 2002:aca:ab57:0:b0:354:febd:62c9 with SMTP id u84-20020acaab57000000b00354febd62c9mr10740691oie.156.1666379627356;
        Fri, 21 Oct 2022 12:13:47 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:46 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 13/26] doc: Document PairwiseCipher property
Date: Fri, 21 Oct 2022 14:12:54 -0500
Message-Id: <20221021191307.31492-13-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an additional optional PairwiseCipher property on
net.connman.iwd.StationDiagnostic interface that will hold the current
pairwise cipher in use for the connection.
---
 doc/station-diagnostic-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.txt
index d1a340ad4d5a..a974b8130c3a 100644
--- a/doc/station-diagnostic-api.txt
+++ b/doc/station-diagnostic-api.txt
@@ -43,6 +43,12 @@ Methods		dict GetDiagnostics()
 
 			TxMCS [optional] - Transmitting MCS index
 
+			PairwiseCipher [optional] - The pairwise cipher chosen
+				for this connection. Possible values are:
+					- CCMP-128
+					- TKIP
+					- GCMP-128
+
 			Possible errors: net.connman.iwd.Busy
 					 net.connman.iwd.Failed
 					 net.connman.iwd.NotConnected
-- 
2.35.1

