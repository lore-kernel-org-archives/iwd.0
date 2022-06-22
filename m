Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286A3C2A
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 23:55:58 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id c24-20020a9d4818000000b0060c2372addeso14221548otf.11
        for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=eE1dn5Nh6bnPSN7O0lsWFsQE1Ijke6mH3mVn098Vc2o=;
        b=CKXq79F/uANtzWQlmmwBi27HK7zNJLAsk/l11QMJBrFywk1KQNGaFRp6eR7s3xQTfY
         66QhgZURDek81MAhvwfgi73x0G+430U3+dAXHhAQkvd+EpinaDyjfOnX3Fi+6BOv/lx0
         BTgAMbS1w1ad2sWXt9kzlT6lnpwIPD/nW6Nn4jUGfkHnUH+xNDt7ZSsgSRlQL37WuxDu
         v/KTFmG4o0I0xB/s7fUfDO48fkEZdomV+hHDfIQYCL4anRz+cuzpSXDIwOmWSs2hwX+T
         B3//D8zRLH1sdBTwqFEjwsVCEn/YEOKmltjmJSfHvuVgiyBVzKvcIUjcmSqaZR9G3UJ4
         xAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eE1dn5Nh6bnPSN7O0lsWFsQE1Ijke6mH3mVn098Vc2o=;
        b=vPoEuk/qCakG2Q1QWXX9Er5PxVII7IybhUkFYAyn60yF7yS7aRV+QmZcl5U+v30b6I
         AubGjyNFoI7ERpSheNbqi7ewg8GLschOCRQGuCm/vIm6cb7wtVKJET6F7wnAdqEUaTWZ
         OBp2785KKxql96SrEBRjJoS+DX+XqWbIdNiR826CM4R7LZSWJzXM0K8pnikUWRAouevs
         nOwtI/ClkKcGY/AkND5IUzwuERfmZXven29MhAomxMPUbtkdsYlrDfssLAKO6Wh85S8G
         RAQE6LcfVpBI3SlYqf1C/tnFaI45aGMa12dKBmCYKimMZRCYxH/20/wrAgw4VZqGS/0i
         bCPg==
X-Gm-Message-State: AJIora+2eShSHJ2qUWBNV4RTHJYFk9KBhiLAOhFkULlHfXEND3zDBO2h
	gmxE6weX6g8/aCngo3cwq5BPbF622OGSkjFr
X-Google-Smtp-Source: AGRyM1uALA0dBXu1glxHPmk5kHCMC5QeENHKAKcgn/ps9i8GCYMxryijXQCzurLyvs8T3p/Rwt3Mnw==
X-Received: by 2002:a05:6830:3497:b0:60c:5afc:8680 with SMTP id c23-20020a056830349700b0060c5afc8680mr2566652otu.133.1655942157860;
        Wed, 22 Jun 2022 16:55:57 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id fo31-20020a0568709a1f00b001048a098180sm3578729oab.50.2022.06.22.16.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 16:55:57 -0700 (PDT)
Message-ID: <b09287cf-e491-d187-460b-b26b0006ec25@gmail.com>
Date: Wed, 22 Jun 2022 18:40:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] test-runner: fix matching with --verbose
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220621182518.1308203-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220621182518.1308203-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/21/22 13:25, James Prestwood wrote:
> The new regex match update was actually matching way more than it should
> have due to how python's 'match' API works. 'match' will return successfully
> if zero or more characters match from the beginning of the string. In this
> case we actually need the entire regex to match otherwise we start matching
> all prefixes, for example:
> 
> "--verbose iwd" will match iwd, iwd-dhcp, iwd-acd, iwd-genl and iwd-tls.
> 
> Instead use re.fullmatch which requires the entire string to match the
> regex.
> ---
>   tools/utils.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

