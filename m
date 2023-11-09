Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F937154
	for <iwd@lists.linux.dev>; Thu,  9 Nov 2023 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGekplWh"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a90d6ab962so15353077b3.2
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 11:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699559844; x=1700164644; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COvoXqVLx8USkANmwBKucd4HSc8xBPj7Uy8qcDo47ng=;
        b=jGekplWhwQlWafigf0dinygvrRxcQOOdTBkb0pXkh3HZ4l1ldkN0fEfeLQYFaYWIkc
         HLXtPAqp2aSDGLJDdZBPvQL8YWJF+zFmkLhd09BoA3uUwqhJP4Xh03RU5bgb+/21rcc8
         p3EkeZ12rjKmkBkkxCwFJ53AQlJb6GXa0E+ixhvk2r+r1Ex8CBTGPuFm2Y2xWAB9ayZx
         cuV6jaRvXd+4/zL1hRsu6yKmIomsPas/HcoZZIfH2JHI2wSI6nQww1VvxiI4ID69OgF3
         9JnbX3HeD3AYTTxptDwOKYCcGx1Qv45Alf2WAjJ/Y3RwPFWPhRUwoFIt2Poeb9pnVUre
         aStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699559844; x=1700164644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COvoXqVLx8USkANmwBKucd4HSc8xBPj7Uy8qcDo47ng=;
        b=RmmKcsL5c2lv+t4ZO7RAt+GHvspqDbVre1Qx2Q3xSKaHWH9KIMTgoULecADPsfeXqx
         xkCwgtiprZdkuoeBDni+74VVYi/jOwEF4YEEyV/c5hYhptk3v7cEnFrcjbBD4FlD0N6n
         2Vv0mDeSrqL5b5pCOY7Tmz7hKavg8Jt3YFz0ncQibmyealYG569JgxwczsY2Ettjeqxn
         EbsrE2CGfW0+NPE5oXjzpbR5GekkgsysJ9ssqLWKKQtprBwfnhEfvZbfcFsx30FO7ZT7
         qrBIBmXDG1J4pLn/1/k8tybsIvRw1VmuUQhLHU94DYKk0bfVpW6ltuWEr8kuO/p85WiS
         Peqw==
X-Gm-Message-State: AOJu0YyLqs/pwsfheTTjrikRkaNGCBQG3Z7QEKjbE4PuRkwXBaoBXToc
	6o6gOQlcMTCWZhYxsuqP3bmZkdUaUEg=
X-Google-Smtp-Source: AGHT+IFGBumkepJnfPo3MQRyJu2F5mObx1QqsocvG5pnBVAd2fBaihVUaaFqkpIjxhG7cTGjhL/icA==
X-Received: by 2002:a81:54c5:0:b0:5b3:26e1:31fb with SMTP id i188-20020a8154c5000000b005b326e131fbmr6564887ywb.28.1699559844672;
        Thu, 09 Nov 2023 11:57:24 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id w6-20020a817b06000000b0055a07e36659sm8052388ywc.145.2023.11.09.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 11:57:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/2] Shared code scan discovery (improvement)
Date: Thu,  9 Nov 2023 11:57:18 -0800
Message-Id: <20231109195720.56352-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had talked about this idea but wanted to leave it out until the
initial PKEX code was in. If we want, we can make this the default
behavior because without it PKEX between two IWD clients is unlikely
to ever work since there is no way to specify the frequency. You'd
just have to get lucky and have the AP be on one of the 3 channels.

I don't really see a downside to making it the default and removing
the option entirely, but I left it in because thats what I had in
my tree already. IMO anyone using this feature would want to set
this option.

James Prestwood (2):
  dpp: scan to pick up extra frequencies when enrolling
  doc: document [DeviceProvisioning].EnrolleeScanDiscovery

 src/dpp.c          | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 src/iwd.config.rst | 19 ++++++++++
 2 files changed, 112 insertions(+)

-- 
2.25.1

