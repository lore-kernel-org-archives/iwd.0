Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51761366
	for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 00:34:15 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id t24so18349425lfr.4
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 17:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmukt8hbAQ6OYLAesIFTsgoSUm7QKb1B9ya/n01cBGI=;
        b=1i9vIDOX5qT7dxDtvvaDFHj4xQ6VEoSB4DSwvNKkF5ODDeo+gpxFcrXOeje6QP3Itv
         12lz8Kimng/juv4AJwlhZkDJu6C+LdV5xvbY5eWQ22iEw6v++b5cjtEkOX2LPpNoBF9V
         WCRawOzrjqj28uTdD49B2xoLiV7NaxIz877iQ3aHRk1JNU9cGSGzskX50pM7PmlliC7K
         zEgs7RmjYuIQz0t1blaaB2OYvbo9UPbr5+CYG0PYLmZI3GjIXUPx06/g0JG2xFABbvUl
         5Lx7rq2cMQ3CRGzmWjBqNLECcsQ3daAFyZD+UPk0RbD9RSG8mhe/5no5V/S75kPNSa+A
         0SUg==
X-Gm-Message-State: AJIora9VphMRy8YmomVoNwtX1Rn6vOdxxAndEG6+tQoZfBqcW4F1aXlF
	X9DHDPMscF3aQ5xpT2Pp3CKN3F8+2UGPkw==
X-Google-Smtp-Source: AGRyM1sI1fgIHzaUS51SoE5U0wcK8738mj0cBsNngfSGINCxTtuujAPhbF0eQZtzQTiHU5LzgAGMOg==
X-Received: by 2002:a05:6512:4013:b0:47f:705e:379e with SMTP id br19-20020a056512401300b0047f705e379emr3675393lfb.457.1655944453736;
        Wed, 22 Jun 2022 17:34:13 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004791c4858e0sm1230478lfs.114.2022.06.22.17.34.12
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 17:34:12 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id z13so97029lfj.13
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 17:34:12 -0700 (PDT)
X-Received: by 2002:a05:6512:11d2:b0:47f:7ca3:c533 with SMTP id
 h18-20020a05651211d200b0047f7ca3c533mr3638464lfr.388.1655944452704; Wed, 22
 Jun 2022 17:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-15-andrew.zaborowski@intel.com> <c03620f4-c330-ed3e-b7f7-67b8ed99bff5@gmail.com>
In-Reply-To: <c03620f4-c330-ed3e-b7f7-67b8ed99bff5@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Thu, 23 Jun 2022 02:34:01 +0200
X-Gmail-Original-Message-ID: <CAOq732+b+iP+Sd4qBWomfNprGyE61Wrg1OhHFnyjYryYVXcBUg@mail.gmail.com>
Message-ID: <CAOq732+b+iP+Sd4qBWomfNprGyE61Wrg1OhHFnyjYryYVXcBUg@mail.gmail.com>
Subject: Re: [PATCH 15/15] autotests: In testNetconfig verify routes from RIOs
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

On Thu, 23 Jun 2022 at 01:52, Denis Kenzior <denkenz@gmail.com> wrote:
> On 6/15/22 19:02, Andrew Zaborowski wrote:
> > Verify that IWD with NetworkConfigurationEnabled creates the off-link
> > routes for Route Information Options in the Router Advertisements.
> > Sending this last because these options are not supported by current
> > netconfig code and the test should fail without the l_netconfig patch.
>
> So is this true?  Didn't ell commit:
> 9c5cbf5484b2 ("icmp6: Parse extra options") add off-link route setting directly
> to l_icmp6?  Shouldn't this work with the current (upstream) netconfig
> implementation?

True, looking at the code this should work together with the
l_icmp6_client_set_rtnl().

Best regards
