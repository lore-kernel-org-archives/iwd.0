Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71053D518
	for <iwd@lists.linux.dev>; Thu, 27 Oct 2022 19:03:24 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id g130so3381267oia.13
        for <iwd@lists.linux.dev>; Thu, 27 Oct 2022 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UeQ32bolSpq1JS8z9PlKxIV15dK7PKUqC5uPkjHvG44=;
        b=Be/i4hS6dpbTTvNQBNmHt8irYuFuj1KWS+qyjM77k8QSyfUI7HD59ZfJIMv4qMNFmo
         +wr/xUgbWszPXFgaBs5kM/4Vb3Y3A0gz15qEM46H0aXtCYLLmB8hINYZdDldXzrwR1Uv
         iLPAxdha9og4Hszg7zh+wGVSFmmRLwBcHixZgIcoiJYdhLNJ3xkrrxhiXf8C+P37Jj6y
         gZmsXbsfGMmnKS53ST+BgRQWmTChcSkF4LZa6wdq9rnGPid9jkd6vxpcp9hXAk0mEDJ7
         vXqSuC6UqCAHe1aPajqBesMl43a3r203FigX01HAZxMBnKWUibzDUlVjP7PGCNrIYvop
         JZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeQ32bolSpq1JS8z9PlKxIV15dK7PKUqC5uPkjHvG44=;
        b=XpHopquYXp0/alvHzCKptgIrYUvRtzt+NnSKJwEmF0IJnp8ptXPgE/qqPhukiTODUx
         ziKlfvOVA+2uK2CG1ZCtw4pgOh56VgVTRnU2OijVV/9VYmE8xb6bEnjod77vm6sqQ0/7
         Uha4E4IwuoprW7twLTziBCbE/BYCyILCsFta/QZrfUyFYjqDr/7CJwj19ZCqdG+0Hs7H
         eXoP927l1vnSOLntJLRfLw4LpNl9UQgACZbStCeVRxnJwad/fRGVhFYW2Kcgb6TRGjQR
         U1tsVgzFNajnJZdUU2JT8xtB96CPJKqMZE4MYUsoPvLu1Sgd3zY7X/1F9DE/qaR8F5w+
         W8mg==
X-Gm-Message-State: ACrzQf352+/+NwZf1HdghdHDku3jy0IAurYeLLGiwnQUFJYb9Bwgj622
	3MHX2wjysQ6LNOmvnOv1tcQ=
X-Google-Smtp-Source: AMsMyM7nx+wCgfviNDpO2yGk7CklgATU3CNaclTVdmHxXMMCbpwRfbBoF+zgNxQS9V5AtHifBNiRrg==
X-Received: by 2002:a05:6808:e8d:b0:359:54a5:906 with SMTP id k13-20020a0568080e8d00b0035954a50906mr5733009oil.151.1666897403411;
        Thu, 27 Oct 2022 12:03:23 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id fq39-20020a0568710b2700b0011d02a3fa63sm982045oab.14.2022.10.27.12.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 12:03:22 -0700 (PDT)
Message-ID: <aa32daee-5163-d948-c62b-d864f2edfb05@gmail.com>
Date: Thu, 27 Oct 2022 14:03:18 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] monitor: put nortnl check into nlmon_print_rtnl
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221027181842.593176-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221027181842.593176-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/27/22 13:18, James Prestwood wrote:
> Doing this allows --nortnl to work when reading pcaps.
> ---
>   monitor/nlmon.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

