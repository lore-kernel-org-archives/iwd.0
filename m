Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2833207
	for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 15:57:10 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id i3so11103345pfk.9
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32F8weFQB2tf4HtcPu4l/OqVWpfO4fNvUgXRBN2SQQ8=;
        b=nawMUSXhlXucAVZaGJQK3nz5nYt+KdE0lB2MbrQVYnr2rvttmyZtYQMJ0mQneVDABI
         UNFLHUvNeftDgFOuqeWNRhF/B6p4KtvRkoMIn61ZYyRqrjHLUYEXHL9nO145/0PSgJhd
         jh4zlDMQqilqgNERR/0z3C88C3c+CfIDZjnsiL5YOhbW2+bury/kjdxD/TLcs7o/NIiw
         YhFHtMv6iXc8v5tjddKZ8zDBsmVZGa6zy/lNkVL33jWBFKUwvZWAqfvyaoHNrgOErKo3
         GCKPmkoSIv3MsfU5FREUg0306sOWyJBNE0WVeQv/+YzGdsit/Quiu9wpr9CEUI9lBMpT
         CpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32F8weFQB2tf4HtcPu4l/OqVWpfO4fNvUgXRBN2SQQ8=;
        b=Fz7HyhbYXmKvtEkS6xzCJpxuVm9MHQ+XJleLkY0AR5cNPj9gH0hJ835QD9d1ivg7cO
         A7YP8Fp11/aO7ydVTZHjPEGbwcfx1VKXYYGLbG1LFszRSA2GXMWnYmzaBHuAooMZ3XKr
         EQopFABc3aJOFXvthsZzgMKPzuZCMNWRGIAYF8Frpv927sF2xvbDPpL02HOcy3VmUGIu
         M9lwhBAbhTpn4nRGPV1id6mLv8A1FqTqKcE39xxJLb0wrlLELAh5Mxqxl4N8x3dhHnf/
         WnG8aBvINNpppcksNwBt3xH6UWYrC7PBLEN9eHGVr65rFjf8MJi7bNuEgAMTdJNOWhF1
         IOCg==
X-Gm-Message-State: ACrzQf13MhQeicBkip/fGms1Wu4h3z5HOzJGjVyHRoknUQktypIWP2LA
	N/V152tveDaOsjRHVgMWO+ZlikQktTI=
X-Google-Smtp-Source: AMsMyM5Frl8m0fBSisFBQvQ9Txa3pWbLFtLo4hNxJrA/4tKCPZpO6Hpf+WtWnhftMzmqISBmFUXavg==
X-Received: by 2002:a63:5a63:0:b0:42f:e143:80d4 with SMTP id k35-20020a635a63000000b0042fe14380d4mr17439951pgm.456.1665417429922;
        Mon, 10 Oct 2022 08:57:09 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a2a4500b001f2ef3c7956sm9341081pjg.25.2022.10.10.08.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:57:09 -0700 (PDT)
Message-ID: <72fd6e3e0ee1ac040f4ad1af0dcffc5f693b3c5a.camel@gmail.com>
Subject: Re: [PATCH] client: handle wide chars for table rows
From: James Prestwood <prestwoj@gmail.com>
To: Pinghao Wu <xdavidwuph@gmail.com>, iwd@lists.linux.dev
Date: Mon, 10 Oct 2022 08:57:09 -0700
In-Reply-To: <20221008075509.26252-1-xdavidwuph@gmail.com>
References: <20221008075509.26252-1-xdavidwuph@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Pinghao,

On Sat, 2022-10-08 at 15:55 +0800, Pinghao Wu wrote:
> Try to find out printing width of wide chars using current locale and
> its byte length before falling back to non-codepoint UTF-8 bytes
> method.

So IWD itself only supports utf-8 so I'm not sure adding support for
wide chars in iwctl is really useful.

This function is for printing table rows and any data in these rows
comes from DBus, which will always be utf8.

Unless you have some other use case I hadn't thought of?

Thanks,
James


