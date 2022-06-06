Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D33D86
	for <iwd@lists.linux.dev>; Mon,  6 Jun 2022 21:34:35 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso1803880pjk.5
        for <iwd@lists.linux.dev>; Mon, 06 Jun 2022 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cs7070vnemTkYcaVpg9G1hlkXdk02BD9HTAql7NNiPg=;
        b=LhiwIYM2SCiC66nDEyhta2XzSv64oPgUfw5wW0x8XaSpZecSdXEfYPiPl0J0G5U64g
         iIisYWZCoxjQo4t0oIPzhbBM3xiHp01ZIuhyfGe/GXUyQr3+k1MsZdSf5OwArUDWt6eP
         OTeJmzYOMxL81o2WFCzLOKtoaZaigAFrAnDw8/UWHv6rhWhMvw8/D6tf6whHoYWe6fwo
         ogOBgHswBlcCuwpmDKsY+ZhJNf2rnS1Gd2BAG/Z8KidA7I44cUssLORMQl+kvr/mLE2t
         INKX18mFAE8rzDYMc08CKMPUVUAQEjbmPeEM5UW0+9n9WlGVM9U6S8YH1ruksWSnPoJo
         Sv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cs7070vnemTkYcaVpg9G1hlkXdk02BD9HTAql7NNiPg=;
        b=te052ol4mnrXwKYx5PpodCamM6I9WEsvQl4hzZe78934GJ0hLvRwfni/RWHB/iCOE2
         pb6GMBLt17F59iudJRQiEs1YLZMTi7EScot1U5VnUbo+JLBTpQG4zh03O1tUevEYalKY
         YpdAN9b5XAYJiSEb96EghPmxoAhWn2EPpmjzMTkc7N7XKHr58UzX9uqWLv9RxBAEj5Tw
         0WTs5QwSVGAuTiTp3ztRhDh8/hfc/XslkVDHKD/Cyf0BxMjfc+LTbOwSzqaHbyFBtEc1
         tX+jIix7GyeMVH07YH+QdbJP+zCpxWkWyWVMpiw55HThZCj/n5Bhe8lpurOXcP7XsPXs
         PzeQ==
X-Gm-Message-State: AOAM531AG05yhLaNsXx+myu/iekNT5UvoFufIY+OStdSvsxwULtu/jXZ
	VD7Fg56UvTu+8NnpuIihiJZiI9JkXL0=
X-Google-Smtp-Source: ABdhPJyp39G0Aljzidu/XgxWl1p9Q30FGGEjyF7nFBZjQ43qGLgMk2RKJN3ej+c8PabKDBXgHa+L6Q==
X-Received: by 2002:a17:90b:3909:b0:1e8:4669:ce47 with SMTP id ob9-20020a17090b390900b001e84669ce47mr17946615pjb.124.1654551275108;
        Mon, 06 Jun 2022 14:34:35 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b0015e8d4eb1d7sm10872065ple.33.2022.06.06.14.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:34:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/3] Patch 2 should fail incremental build
Date: Mon,  6 Jun 2022 14:32:13 -0700
Message-Id: <20220606213216.36873-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also testing cover letters

James Prestwood (3):
  station: should still build
  station: this should break
  station: fix the build

 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.34.1

