Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23597E
	for <iwd@lists.linux.dev>; Wed, 23 Nov 2022 15:32:22 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id d185so17825231vsd.0
        for <iwd@lists.linux.dev>; Wed, 23 Nov 2022 07:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YtEJnX9steO7xIw9cdGaWVKVhubFm/r2uW5dJNrTuYg=;
        b=KaEXlLFnTyPviJY4WGAzkdVnfmCuMDJTixcftEC2R5KZU47jpkx69rqoqQFgapugOb
         ltmvFjvoSvATxB9wt8DMpyBc1hju2B6juSnqAewuZz97XA0rzKOibM2Ry6z0AEFPhfm3
         Q7VRpxeS+2DG/QPC/nsrXKR8mFUk47jvy6IfDdQ9H/GkFCncb64o96V6fLjprsLl2Fm+
         CO6rIcqM5xEJiz1wk0OJP0Eo5mg47mygdAKAGobah2ny5V4H4sWej1oIeyd37u5XKaqC
         AWpN3MQ34h1OE5tJG5G0tvIzJi733HcxRcyfbG0/UEhSxZ3gZe9P5Up9fpJTbCSyeVsQ
         YSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YtEJnX9steO7xIw9cdGaWVKVhubFm/r2uW5dJNrTuYg=;
        b=1QFKhSVzZeNcrWDx6V6qZdCPY/XH/DAJtIUYY+e3tnetycLdpw3lpAklKF5GIc7snl
         YGNCodx6m3iLHyaBfE+1V14NrLEthPslpMR92wxQpb109s2RWj5zh5kgyHvHa4G+e7Fm
         q9roeqf0k1Hdv79P8X3XYakxiNhCRghO1yyM/5c8jAy9c+0/btTajLR5SfiQiH9JZfsM
         xcYnjZpk5qmqsaZ3WHl85nbROtmJGcikXS1pTtBIcrAgLj6zAu0PuamopgmprF2M+W4Q
         /5+uIPn+YL6eEE1wNS8lt4zSrDUxb7VpwU8ezaLjzNbvuIwKKlTBe4FcM103y40luP7O
         S1cQ==
X-Gm-Message-State: ANoB5pn93+gDnCp/qgiR0+1IiFg4vEMAFyQ8Ftm/Umw8DoK6VcVWID2G
	sV65e0haK/VAacY6DeGrb5xi3+/ZLqgQ/zgMwPerrsZlftNcDg==
X-Google-Smtp-Source: AA0mqf5AH89CngXfOFCRJpewHq3+uqQAQOtPVTJwmnRXuhwi7NGrhIvEtZWclXhZ1yXO+Qur6HHmQV8U0Uol2gFaPLw=
X-Received: by 2002:a67:7c3:0:b0:392:ba81:9854 with SMTP id
 186-20020a6707c3000000b00392ba819854mr17423832vsh.51.1669217541530; Wed, 23
 Nov 2022 07:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Nikita Zlobin <nick87720z@gmail.com>
Date: Wed, 23 Nov 2022 20:32:11 +0500
Message-ID: <CAGaigJP9aDt3hiQOVbg4U_x-_6T1+FHbimEE1KLBD1mYumJPaQ@mail.gmail.com>
Subject: DBus service startup doesn't work with regular DBus (PATCH)
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

IWD dbus service file is usable via any dbus. However, command to
start service is not set, which as far as I understand means it's
hard-bound to systemd.

Simple change of Exec= line to meaningful value fixes the problem.

Patch URL: https://bugs.gentoo.org/attachment.cgi?id=819160
Original discussion: https://bugs.gentoo.org/831631
