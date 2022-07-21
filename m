Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE25441A
	for <iwd@lists.linux.dev>; Thu, 21 Jul 2022 13:26:21 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id y9so1729016pff.12
        for <iwd@lists.linux.dev>; Thu, 21 Jul 2022 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cU9KN/REKDFwsmpJYX7NdvvCC+jUOz+qlxjxHGjrUNQ=;
        b=VyHBL6XA0LpW1T0J9T5LVsA6lQV9vjbMGGNR9QAokW3k403ZzGDdpjZbXIq2QlQqWE
         HhNMo2K6IzOwqNi+dmfBUe3+8OPKVtjPuljxcA2+blO8jKBTMZKK/wi+HFira9fsxWYG
         YF9z6lAPDu+h5/SH53FUr/5oGcU8QO0uo3LrKZ6JbIXd8fbSjiabW/rW61sZlDritbHR
         UjQV3pal4hJdQrF0iqepyR2zxlQNpCGG24KOvCPCzlBRmJmlRTca+ksdcJqLjNJwzuM8
         nCdv2BVtoAq85cjWeFWIArywqEyn70owDe7pbEEeospOykesOawkxhYrN9WWerWJoX2S
         Ac4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cU9KN/REKDFwsmpJYX7NdvvCC+jUOz+qlxjxHGjrUNQ=;
        b=6C6B4Ss4ZRSV1r9XjsmNyvtN7tmEXw/6oJZPXGp0w6x7IFry0rFFNacwBxjfoQqVvF
         BWWZtn2BsHu6UG+ivufNthW1qzYTT2AdATgYPafWVaXLStU8yvLEYWdClIGvo2P+T9xU
         c9isCemUF7yVb2os/GshEgFlZ+VIsgeCpNMV9sbsZOEKQZQS6vMC9Hp/uSv1pbIjE6H4
         dfyI8CU5kGmP2PjD1GTVvmliu8RljXJgC3Xj5nNDDSigETy+0yH9csz5SpBCbyYpjswE
         ywmAlJCRkcnk2mLTQh65M2of+bwEzXcj1cR6RrARMmzdzcij248Qt5KaEZcsWJNTLTEa
         e2Dg==
X-Gm-Message-State: AJIora9lqLyrDdlxuypEBWRmB2iYFqHwEG8uK1Ue3nZGLNklCkgynQsv
	O8LYPp5MzhMpSLCb5+8cQXOCJtrRTVAUmIWf9Qo=
X-Google-Smtp-Source: AGRyM1tNe26QKEdkOa4hKadi5LuFlLxTbvBqTmv7QU0c3NthaoQ4i3O4k7oE9FUZu0ngAgGuJYiCiolbf+JduvbIq20=
X-Received: by 2002:a65:6bc4:0:b0:3c2:2f7c:cc74 with SMTP id
 e4-20020a656bc4000000b003c22f7ccc74mr37704636pgw.307.1658409981242; Thu, 21
 Jul 2022 06:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220721021314.14066-1-denkenz@gmail.com> <b240184c-d90a-db5f-e7f0-ff2c5b432e6b@kvh.com>
 <daab977b-fdf1-274b-0ebd-45d71b090500@gmail.com>
In-Reply-To: <daab977b-fdf1-274b-0ebd-45d71b090500@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 21 Jul 2022 08:26:10 -0500
Message-ID: <CAG17S_OysUm+YSDobUTLnY3k7mU86WMoVRY7D3iz7dFMBYYopg@mail.gmail.com>
Subject: Re: [PATCH] tools: Add simple utility to generate the PSK
To: Denis Kenzior <denkenz@gmail.com>
Cc: James Tavares <jtavares@kvh.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

James,

Interesting... Which arm distribution are you using?

Keith

On Wed, Jul 20, 2022 at 11:25 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi James,
>
> > Awesome! Thank you. With this, I was able able to confirm that there is
> > indeed a problem at the 40/41 character mark. Passphrases of 40
> > characters reliably produce the same pre-shared keys as wpa_passphrase.
> > Passphrases of characters 41 and greater produce random pre-shared keys
> > (although they sometimes repeat, as-if there was an uninitialized
> > memory, alignment or aliasing issue?).
>
> Using your 41-char example:
>
> denkenz@localhost ~/iwd-master/tools $ i=10; while [ $i -gt 0 ]; do ./iwd-psk
> ShortWiFiName 00000000001111111111222222222233333333334; ((i--)); done
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
> PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
>
> Not sure what to say...  Maybe there's something subtle being triggered by being
> on ARM? Kernel bug?
>
> >
> > My other observation is that iwd-psk (@ 0.450 seconds) is considerably
> > slower than wpa_passphrase (@ 0.017 seconds) at generating a pre-shared key.
> >
> >
>
> Yes, that is something we're aware of.  Kernel doesn't have a native pbkdf2
> transformation, so we end up re-trapping into the kernel many times and that is
> slow.  Hence we cache the PSK for subsequent connections.
>
> Regards,
> -Denis
>
