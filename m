Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D57C
	for <iwd@lists.linux.dev>; Mon,  3 Oct 2022 15:29:48 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1321a1e94b3so7608106fac.1
        for <iwd@lists.linux.dev>; Mon, 03 Oct 2022 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WvdT+S5rMbTmw2+zNr4/kI5bSnivQFvCpKsGIigW3fA=;
        b=S7Wryz7+ZDUJXluE4SaEuUafEUaMU616BYWrT77X72g6abtFfs8LcO9XdJj3p4Kl7q
         bc3tveo243uN2soRKSoYNo6cI5G4IXeL9oJUtRVzLcBAfSFTcPRVcqb16B33/BtPztZI
         bWQ+hl/HS0lF3pK5/1RGqtZoELiyQU/tIWlZPn6pKN0cCIE3Wq67EzIc4+9RomKsAdhf
         +vC3hSTVDABAMrWniQwIqp4Dhxl3rkAZI5TgmFMdhxEWTKg0VSbShrINDNdKVnWDqdOB
         qOYIJAWCjeAKw+H52Uzg8+oBLB96eahBeFE793dT++4D2J0WFJ07IgLakxr1/MIbdNh2
         EGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WvdT+S5rMbTmw2+zNr4/kI5bSnivQFvCpKsGIigW3fA=;
        b=Z0+kYlTmbus/VO3BNCy9GauTtlm+gO1Q8mFzg9vXjBdUt0BWugyn+leELCU6Ey4+Ux
         Viw+GxbSet0+rTRJn9K0NhqZOZWSdccyGLCiUqWXqpqwd/arh4VNeq/YLdKx7xZyEBsW
         oYngS9zFFjQWDefnqX/1tE8yYpmiNbzrBXYh4QYDieVh17j3O03qC2VAbWZYFsA0mewP
         C7b/vKv1UdfBBBuii9ewg/IuAWDHe+14I0b4i0nBw3u83PLFuHgZD1yvC/z8RCvVXcdt
         sJv3g/HV6TOncZfyYIZ0ZNpNgQNvN80oTzs0XQN+A/JEaHKwTF+pO4Z6dlpVuc14i+zd
         syKQ==
X-Gm-Message-State: ACrzQf0MWZ+wfGeIDj5WYnpMpIf3rIh9fHXmwsd7avn80pvUDFCtrmT/
	jpEzsbdgKJYMeZnnfXYkDq0=
X-Google-Smtp-Source: AMsMyM6twu2O/QakB3nvQ+Kfp1aKAhP19iS8SebEE9OWl1pGERIxlOPYfkuH1k7snANdO9n+NotL1Q==
X-Received: by 2002:a05:6870:2197:b0:132:7cca:a74e with SMTP id l23-20020a056870219700b001327ccaa74emr2000897oae.212.1664810988008;
        Mon, 03 Oct 2022 08:29:48 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y37-20020a05687045a500b00130e66a7644sm3006664oao.25.2022.10.03.08.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 08:29:46 -0700 (PDT)
Message-ID: <594428c7-954c-3c6c-69bd-fdca185a4f83@gmail.com>
Date: Mon, 3 Oct 2022 10:29:45 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] doc: Drop proposed and unimplemented API doc
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220930144801.548229-1-andrew.zaborowski@intel.com>
 <20220930144801.548229-3-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220930144801.548229-3-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 9/30/22 09:48, Andrew Zaborowski wrote:
> ---
>   doc/ip-configuration-api.txt | 47 ------------------------------------
>   1 file changed, 47 deletions(-)
>   delete mode 100644 doc/ip-configuration-api.txt
> 

Applied, thanks.

Regards,
-Denis

