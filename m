Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0D7499
	for <iwd@lists.linux.dev>; Tue, 21 Jun 2022 21:18:12 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id a13so14598486lfr.10
        for <iwd@lists.linux.dev>; Tue, 21 Jun 2022 14:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/r+hVYYZxqfYHIYEHJKyauA4sC/Z+gMTbf2AObmOfo=;
        b=i92u6zFBgshSxmErfWj4fA112pxTzolNHTHtOOTxOLWP9dBMX889jqVWr2fyffcoeS
         oTfE1czjKMAYVXT3nmv66cAES/MYkQcOXCNwnBuHV1V4jMGDBJv61mK/8v7K0fwYyqaX
         dSLwySTaQDq0oEpT5ZtcfpINrXBvmHOsMPW0F13Z1A7Axh0iWLMzsa2RoTzFaLsDiAaX
         mx543YZnxuJPDaayE5Igjgd4W080d6PswHJia5p2YrhsyX4NMqXD8/jBpmFLdcxo4dRo
         hn0nUvOURlbd6mWtpcS3q2FEH4n+piRViQ/bC8HNIUxSU1+t+DCIEnYjORv8XgM6RQaV
         Ku4Q==
X-Gm-Message-State: AJIora8+m3QcyxM+l+rZx4+JxIzUQYNGbHCm7bcslw8mxAKhYwbRudRC
	UV6DF0Pj96Yuy27yTcDxTeASDqLXHiw/jw==
X-Google-Smtp-Source: AGRyM1s68Bkp3EaqOvr1Q5AWdvOtec3az55GIuMNp9m/LAynYxIUEuMOrirP1PKKAHf4L5uPlUoTdg==
X-Received: by 2002:a05:6512:c21:b0:47f:6392:dcf5 with SMTP id z33-20020a0565120c2100b0047f6392dcf5mr130431lfu.117.1655846290539;
        Tue, 21 Jun 2022 14:18:10 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r10-20020a19440a000000b00478f1bd611csm2290348lfa.284.2022.06.21.14.18.09
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:18:10 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s14so10216882ljs.3
        for <iwd@lists.linux.dev>; Tue, 21 Jun 2022 14:18:09 -0700 (PDT)
X-Received: by 2002:a2e:2c0e:0:b0:25a:6b43:eff8 with SMTP id
 s14-20020a2e2c0e000000b0025a6b43eff8mr30509ljs.299.1655846289821; Tue, 21 Jun
 2022 14:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-14-andrew.zaborowski@intel.com> <a0ee1952ace452c971d98cc208bd9d9eac1a3e92.camel@gmail.com>
In-Reply-To: <a0ee1952ace452c971d98cc208bd9d9eac1a3e92.camel@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Tue, 21 Jun 2022 23:17:58 +0200
X-Gmail-Original-Message-ID: <CAOq732KZuR=cqNnozGDdnR94AAgh-B2Hu0patzN3smL_oSf=rQ@mail.gmail.com>
Message-ID: <CAOq732KZuR=cqNnozGDdnR94AAgh-B2Hu0patzN3smL_oSf=rQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] autotests: Add bad netconfig settings scenario
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jun 2022 at 23:04, James Prestwood <prestwoj@gmail.com> wrote:
> Does this happen to depend on patch 13/15? I applied all the other
> autotest changes but this one fails to pass testNetconfig. The
> assertRaises() call is what fails for me.

It does, sorry I didn't make this clear.  Both 14 and 15 depend on 13/15.

Best regards
