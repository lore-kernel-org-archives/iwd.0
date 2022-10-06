Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43E812
	for <iwd@lists.linux.dev>; Thu,  6 Oct 2022 13:22:37 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id fb18so912899qtb.12
        for <iwd@lists.linux.dev>; Thu, 06 Oct 2022 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=I/HEY49CGZYniocRJN9kwVCEkFVg+JvRAB5OJw9Q27s=;
        b=QMEjanOpQ98yn6zyGZ+gAK8Ms7HfDLM3xESpWq+Mpg0ExtADxUEItSF+OVdFSlERCI
         rPDWr0IHg6K4ziqiPPuCZdFJ788vKyQi7VByYU0SMaihG4CG/vTOesz4JzcJVK0FWuPB
         ZCtMtKPge+apRCjT84pDjU/7WsHn18Dt4fNFyKDwBVqY47pco/HcYEv29zqo7LjYdsaZ
         IwPRECr/MxOeJuqFWEgH37aJEmkKIRrD9s+NYnR926JhQMDEWz3NshmDlfVW57U4jaGZ
         2kmeCGiSzf7P26tbz0opxIi2CTOTTcYkBZoXpuXMIISOAUg0wIKgGdjse9BOlUEZ7SF7
         u6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=I/HEY49CGZYniocRJN9kwVCEkFVg+JvRAB5OJw9Q27s=;
        b=yyMexMrsipfDfLKKrMy8aXhFWCRl2x77ZQ1CjO5jCJrJJMItRCTvKlRo3IWUASc0KH
         B4YP8Fm9nFg4wEllgx/kbNsomNoQBErpJaYV6HW7uvUtJfmlp9PTKP7bLJNgXNdwk7YS
         GS1zZUrYD+MPGbDXGdYqkISjeJd42zzOV+7W1otchMB/Mxca0eG7wb2WFTOZ8FGWmWEU
         gGuxTQ1x6P4Hg69nwEdPBAGHoiMOSkHkcWhNmVoO+/89eLfq3ZqzjrkAzN7Q/RjeYt+A
         hmMngZ+ylRUjwzxVHPUcbjzNllAcBdxMjVgi3LDuNMqEqX/lqMyrDOHHDa3+HsgtqCd7
         BjsA==
X-Gm-Message-State: ACrzQf3CErp9lqEVUFAimVWPaAl2TPTULBfOGFuQ4oadxA+Z9pfQ0gDr
	nIIiKtdnNfXJZd643Z0Pa45n0EXM9K9+cKjR69eHef1v
X-Google-Smtp-Source: AMsMyM7Ux+uMHdyLclgOpMnBtWA9wRsxw3KNiRiuYVbAP8iG/tHX2E6qijSYDn1vFmits0jmgEQMNZnV0Qj+UDMH078=
X-Received: by 2002:a05:622a:1:b0:35d:43bc:d21c with SMTP id
 x1-20020a05622a000100b0035d43bcd21cmr3306936qtw.371.1665062556087; Thu, 06
 Oct 2022 06:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 6 Oct 2022 14:22:25 +0100
Message-ID: <CACvgo52+1i7iZ-vzqf1RUpZvMa3-EgaDoid=Y9dch4=d_dq-5Q@mail.gmail.com>
Subject: GCMP and other unknown ciphers
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Greetings team,

Recently we've noticed that IWD fails to connect to WPA2-PSK networks
whenever GCMP+CCMP cipher is used. Browsing through the IWD code-base
it appears that it lacks support for GCMP, GCMP-256 and CCMP-256
amongst others.

Was my analysis correct - is GCMP supported? Are there any plans on doing so?

Somewhat relatedly - is there a configuration knob that one can switch
and let IWD fall-back to the other supported ciphers? In the GCMP+CCMP
case, we can opt for CCMP for example.

Thanks in advance,
Emil
