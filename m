Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA618660B
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434944; cv=none; b=ZhJzfOgF7qPk4mXRB7jky75QqXoMiz1AdYlp/IomrTjlA5C5RiYd7kYmNNG+i/uhKDfCavXLWDcx19QynNzUXns2Q5B7du6walM9LjFOwTYcT8sJ1Obryk6lBjCYvtl1Jc+OToHdSVENdN+B68xgCKLOYFG88RBwXqWnxm/SZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434944; c=relaxed/simple;
	bh=7ffU0K4HFcNUHBJV3yk/OIFVAaI/7Qhs/esgmZcPMns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COgPZpP3dEHtrOr4l9x5DXEDWDvsoF+PX+pmhglvZXAZlGvvf+ypLIHa8TVnySN2LiFXzPBaykybP/pizQxlm8nKJL+xY/qSrN6156DIyEneQ4Om711umbE+aHP+QuBR8NFV/kPLavRXCpXt3Buo3HitB/ew8/QpjfaGaedUqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqVD/J6y; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqVD/J6y"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2702a00aad4so1539099fac.1
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724434942; x=1725039742; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzxVQ+cdcrpSLpKmcvI8Wd6Xc5dRgyESTgAGBBSy9qI=;
        b=jqVD/J6y0T7v7JACp4CvqzegOZZtjq2TJ8Q86lVkpFQKDq6JCBYfECYuDGBLCo2kNt
         PTnTjr7XYuz8nXj7VWNu/XEQx4GfgUjmoQUZDEKc/s4DGRO5yaB70Q8PTECT2HafpI3C
         Ul4Xuej/Ht6BGHMrV4c3zHQWALjXYVIW/1zuZMnZWy9sSMDms8ax8yLx8CV9rwJ5g9xo
         TCJs3j1QvwWqfW2K5iCV7nl+WIb427ub+lTZd7BOw5Gr8mTTjq9SbpILXfDLi3TgTaTB
         av+jPDEhSb1QiKNhJGobZc7lhVRqDtskB/zpuQ2GllZNm+9OzpSJ6RCG3MVkZOyrav2W
         M2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434942; x=1725039742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzxVQ+cdcrpSLpKmcvI8Wd6Xc5dRgyESTgAGBBSy9qI=;
        b=wgLs8ch3C9rtPE33lKjGXROBfFtT1AhXWHfrLTRRgcnEXMuvRSbmS8vKeUH9W0lOX9
         fYJ/OwZPyW3NmYerDinXqDTQMO4O5Fz5GsehAUBL46QXQmRJwLAsDWj+JjWMVAxAGFHW
         RS+KtCzM+krORGDr2CDlb1XBMhzjYL8tc84SQ8M6IcagPXAZ88pssaXhzfWuZK4WylWb
         CbN5E+cCq6xaIplrm+smDyggffQ6o7/MuS5xSvwCNjXt3CvMZ3RyEDw3MuAtHKLxfb+M
         vmN08C0Y9Q1lIyrLzBc3B+K5/TsDgS/s+vjoI/i9nlusdemjHssQNXx8U4FajeCttjYQ
         LxCw==
X-Gm-Message-State: AOJu0Yz9JQZ78uUhpyl9H9Z8+zg7Dyg5NwWlfjOOnP3NDD/kkoYqMUAF
	qMDSDuoPGn8Zi1g4BDwekCldZXc1VUg27xQVLmc4SZNhGjY5Q17D9JtX1Q==
X-Google-Smtp-Source: AGHT+IGDooptQrLXp8SZhF1ZeshK95C1gAkUnG/l9EdwwnbCfs8UfROjGU3/hinTk74KpU6L/uerRA==
X-Received: by 2002:a05:6871:293:b0:260:fb01:5651 with SMTP id 586e51a60fabf-273e64673b3mr3245370fac.12.1724434942095;
        Fri, 23 Aug 2024 10:42:22 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03aa9c67sm728506a34.30.2024.08.23.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:42:21 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [RFC PATCH v1 0/2] External Auth support
Date: Fri, 23 Aug 2024 12:41:52 -0500
Message-ID: <20240823174220.498594-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements External Auth support on Full MAC cards that do
not support SAE offload.  I have not been able to test this fully since
the brcmfmac firmware on the RPi 5 does not actually work properly.
Maybe some enterprising person can test it on a firmware that does work?

Denis Kenzior (2):
  netdev: external auth support
  sae: Allow ability to force Group 19 / Hunt and Peck

 src/netdev.c      | 258 +++++++++++++++++++++++++++++++++++++++++-----
 src/nl80211util.c |   4 +-
 src/sae.c         |  20 ++++
 src/sae.h         |   3 +
 src/wiphy.c       |  19 ++--
 5 files changed, 263 insertions(+), 41 deletions(-)

-- 
2.45.2

