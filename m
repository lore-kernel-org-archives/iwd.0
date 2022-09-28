Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F14C7A
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 19:53:03 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so2576696pjh.3
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 12:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=66hdlKxJoTzfXoXoYTqvDsTiXCC8BgyIp2XLbg0UHOI=;
        b=T+zb84o9Qche1oPeFePf8TlVTY42z/JB/78zr/gwlGZG/qdM8E5ClMDpMvhMjFLYMV
         SqyK36eZcYKqTYmxpT4Fcm71xHTARSWwYqdVwRhtnNTCNdP+ai9LIRaKCmWgi/uHJ5Sf
         2YiGvmU6EDneMEqCNbNZQsikkpHm1TG53ZhAJsjhHeURT5+HXrVPan+SLHNDjz9GYHOq
         J/e+CZ66mSx16sspxXuMGuvHHBSlNki7yZDainU4hjsj93b/aWXYTm43afL9MA/am97C
         Mn/dI8Ul9+s9iTF1sGyVKFga5dadXmtjkVkUHB0pgGEbJhzUJaOiWSffMSx84IzGOUvP
         3HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=66hdlKxJoTzfXoXoYTqvDsTiXCC8BgyIp2XLbg0UHOI=;
        b=4k+TiKaSudz27n2+gL0U9vK+c36OShlkZXnwBzEOXj4DKkE2r/tDvACHBbonJrY0az
         0vHr5I8GCloSUX2bDKtmDMlXndBm7bxheB63J6QO+F4QGyyUnMCHV/yJUnVDQ7KvVy9y
         s7RYpPGogMy7flYCEZsEQXvAEgj+Kw+DZ22XNmcLFvYjjZ1H/YPuTrVvNApQMGyjbCYY
         ReJOnGFVzfyZboLw9JI+afRex/i223JHOLHMmU90x4oUq6Dmmovlt5vvKAZioiRkOWRl
         1fCywdAqHR/Y9Zq1ppel6IsEDhOyEDox9+X+C9FHdMLey5gUquGELXKQmDZAuUHiO7ry
         6i3w==
X-Gm-Message-State: ACrzQf3FawR9IfmUZIuy7P0k3BJKHSvkMm92V66DwPelwC8mMvbdtMJb
	midCSEDrRSOliw+2usOwcxY=
X-Google-Smtp-Source: AMsMyM5s5WopV7uXNdPYKRVu0hXCHX+CQ2IKds+gL9AI5bI72JmWkEJcadAstoaZrfmnHNHSqihcMw==
X-Received: by 2002:a17:902:7b8e:b0:178:b9c9:97a1 with SMTP id w14-20020a1709027b8e00b00178b9c997a1mr1369938pll.111.1664394782376;
        Wed, 28 Sep 2022 12:53:02 -0700 (PDT)
Received: from [192.168.68.74] ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b00176ba091cd3sm4122820plg.196.2022.09.28.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:53:02 -0700 (PDT)
Message-ID: <af8597070f31d8c5b3df9daa7a79e26201d781f7.camel@gmail.com>
Subject: Re: Cannot turn on AP mode without any error message
From: James Prestwood <prestwoj@gmail.com>
To: Chang Liu <goduck777@gmail.com>, iwd@lists.linux.dev
Date: Wed, 28 Sep 2022 12:53:01 -0700
In-Reply-To: <d007b616-5957-8010-bb01-bae8a5398add@gmail.com>
References: <2031ff9c-0fff-18f7-2ad7-860e2b51ee22@gmail.com>
	 <f66462932dacecb2231bf356770165309c49beab.camel@gmail.com>
	 <7fc91799-e030-fe90-44e9-c6490fbb6bb8@gmail.com>
	 <e5c70eecaa96e951176b6f99912822cb2ef5b3a9.camel@gmail.com>
	 <d007b616-5957-8010-bb01-bae8a5398add@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Chang,

I think we got this issue fixed. There are two patches on the list if
you are able to try them out:

https://lore.kernel.org/iwd/20220928194852.375786-1-prestwoj@gmail.com/T/#t
https://lore.kernel.org/iwd/20220928194852.375786-2-prestwoj@gmail.com/T/#u

Thanks,
James

