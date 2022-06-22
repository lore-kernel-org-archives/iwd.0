Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C894111B
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 21:00:52 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id u189so2593747oib.4
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=nIL3tN9Ea6wde5il0DY7jZdcF15jQuQxgiTkYYqPq50=;
        b=mIj+6GdYSEkWHL7Ij5KAAuxdwFN8CcvftQl2+bzopbFhY4FXqerLApVVGmzTqlFeGe
         Y+n2macovATvT7ys3CNMwbF09b0fSOObLuAv0L5/hvxu/pxHvsQBpYpM9hHqG+rqreky
         0Alv7hV3HBF87rz4xjVKqK1LniBZ645IX3Fbs9TWh1Xw6r9+7R2FfQlBbGkKPfT8PrxN
         oTzQ4huEnRS8bTEHnU3Jb+DGYF1jdTwlSU9RRVOV+zNfMj0ApsAu6pOFs3O4TZCUWefQ
         HO+K8DzlY4d1CuYmcVBLbVYf9wwJo8RxSAbZCQMwh3RzZ/ilb0xdjlOtxuNoWMtokrB0
         KlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nIL3tN9Ea6wde5il0DY7jZdcF15jQuQxgiTkYYqPq50=;
        b=Lnq1MX6+haX6R0GdJgHGGFHtcZ+l6vuRDnzC8+vTyFk8F/oIIgML6O6VMlm1nvP/yb
         mo37wZLciDs/43BVb13gn4egRzWD5cho15rNgIIlP19q45v4+LhZIv0VnByXQBZdOczr
         glN3kBUinObOypnMi8jdMZRV6Gb7Nh8GNM613klCFGFV7e8wsc2hiNFC9z0wCflVdI4s
         2oWUERUw2VvlTMxZ4wwpMNEiC7a7cXVSF29Z9BdafdOnOAuyPiI5PvxCTJsam52DE0Rd
         uuz5YcwV9gqlMjU44elie8zOpE/IRRdE9dSFur+HS0Kdd3PLtwDc7fys2rspYqvG+9+u
         P4CQ==
X-Gm-Message-State: AJIora/R3O/+a7Xy1CtB6Cn4uHF1ds5MKlP/q/90EkiMvRKegOBJTRkq
	DwewkuJ3LE3kC9KsSJ0xzfg=
X-Google-Smtp-Source: AGRyM1uu0e54HkX149nWRJe/xSt+m8Xe/QByC7aXxtW7oONA4ogxJvJKDRxcQIoB7/FFGsYn3cZuvw==
X-Received: by 2002:a05:6808:f0f:b0:32f:7a00:1605 with SMTP id m15-20020a0568080f0f00b0032f7a001605mr171272oiw.276.1655931651390;
        Wed, 22 Jun 2022 14:00:51 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n35-20020a056870822300b00101c9597c6fsm7806398oae.28.2022.06.22.14.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 14:00:51 -0700 (PDT)
Message-ID: <ddc047f0-ea93-d374-775d-97f97452ab88@gmail.com>
Date: Wed, 22 Jun 2022 15:58:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 05/15] testrunner: Fix parsing for some arguments
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-5-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220616000231.1966008-5-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 6/15/22 19:02, Andrew Zaborowski wrote:
> Currently the parameter values reach run-tests by first being parsed by
> runner.py's RunnerArgParser, then the resulting object members being
> encoded as a commandline string, then as environment variables, then the
> environment being converted to a python string list and passed to
> RunnerCoreArgParser again.  Where argument names (like --sub-tests) had
> dashes, the object members had underscores (.sub_tests), this wasn't
> taken into account when building the python string list from environment
> variables so convert all underscores to dashes and hope that all the
> names match now.
> 
> Additionally some arguments used nargs='1' or nargs='*' which resulted
> in their python values becoming lists.  They were converted back to command
> line arguments such as: --sub_tests ['static_test.py'], and when parsed
> by RunnerCoreArgParser again, the values ended up being lists of lists.
> In all three cases it seems the actual user of the parsed value actually
> expects a single string with comma-separated substrings in it so just drop
> the nargs= uses.
> ---
>   tools/runner.py | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Patches 5,8-12 applied, thanks.

Regards,
-Denis

