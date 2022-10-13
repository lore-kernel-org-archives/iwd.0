Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0CA3C29
	for <iwd@lists.linux.dev>; Thu, 13 Oct 2022 16:14:28 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso2320596pjk.1
        for <iwd@lists.linux.dev>; Thu, 13 Oct 2022 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bvT5NFI0i7Gzvz3jxT8e9F9UydOU5F7d48jxLwPrhw=;
        b=Eb5i5VQrJXjgA6wavkuWQC6IGa4g4DzlXAhQOJAegbQf3lmy8NSxTHKGAZd5B8AQp+
         Zt78CBTWZPpKThHhUKS4qhUJL2ERxMDARewZ488hZMwFGYBLc/a3H24RR5jI1Wpc/YLG
         qPPu+Fgs8PHNa2zuXmb8kMZnHgAzlLemMvs40SQNEf9v+sMjAdojyRfeWFv53iPsTVd0
         h/wpglEL/4SkkweVwNnKoxOrWuHzcm2l7u1hnxWA5sAEFYHoi7MrTEFicA4p5E8h85jQ
         TG3ply89oHOX37pVBrQzZyd+n20tSYKkQ0bfNSdeMJY3NIGpn9hpejTSJCjwropx2ACd
         ZvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bvT5NFI0i7Gzvz3jxT8e9F9UydOU5F7d48jxLwPrhw=;
        b=h6HRYecBGcAE3e5vKbDrGv2D3BtNnQ+cISDNRFRd4VMNpNW04e4UIKdseyLvhY3oOg
         T6dR8ToKW9xdgPg8S53W13WxP20ZJfn+MCOCaAFqYmcRwkSlWg2zOhco/9zBPzDLw0UB
         AkBljMVhT3DdxzspRPgDt2M6U4IOHyrsT7PEdSHi+N1jgpnrYcuIUprbq9tfS0mE+te5
         5kvl/20rD6UAqEwaXD67+SJVhKU+Hy0sFMIyPHuVje1BAFd+Ie/Rv+/4qYQmD4VenUMp
         3WhIK4KarprTQSWUfSJ14bdSSIZHU7ERFPlyhGT2WzjgvSTwaLoGycNzlmTierz4EfMo
         8nGw==
X-Gm-Message-State: ACrzQf03AwcNGL1I1K3yQugHhrVG0OhM2VFKkyAJN4dXjxed+EnShEyo
	jYvQ3D4LMKM4Q5IBrvVVOiQk6ObjYPA=
X-Google-Smtp-Source: AMsMyM5FqkkMFXLc8d0huQWLWwTQ9xbA7Lf+kYA337wAK3uLdX5pUp1cYHvWyvJR024ymnsj8bpmlQ==
X-Received: by 2002:a17:902:aa46:b0:178:9ee5:c7f1 with SMTP id c6-20020a170902aa4600b001789ee5c7f1mr478433plr.69.1665677667561;
        Thu, 13 Oct 2022 09:14:27 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001750792f20asm34043plg.238.2022.10.13.09.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:14:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] frame-xchg: use int length for NLMSG_* macros
Date: Thu, 13 Oct 2022 09:14:24 -0700
Message-Id: <20221013161424.505633-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221013161424.505633-1-prestwoj@gmail.com>
References: <20221013161424.505633-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro expects an integer type so use that to avoid any
unintended behavior as seen in iwmon.
---
 src/frame-xchg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 158befd0..142bd80b 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -316,7 +316,7 @@ static bool frame_watch_group_io_read(struct l_io *io, void *user_data)
 	unsigned char control[32];
 	ssize_t bytes_read;
 	struct nlmsghdr *nlmsg;
-	size_t nlmsg_len;
+	int nlmsg_len;
 	uint32_t nlmsg_group = 0;
 
 	memset(&iov, 0, sizeof(iov));
-- 
2.34.3

