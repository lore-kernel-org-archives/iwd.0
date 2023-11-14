Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80612C18F
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeMEH32e"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-77bcbc14899so269548585a.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699983550; x=1700588350; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biflnm0/tB6oVZIwXHCeBF9Ow+KXiRG6M0c54wS4tQY=;
        b=UeMEH32eET+VX3nCymlTrAbCYw8f6hQ5hD+hfNfTkT54bPEriwe9eHDeGHWYVM+hGx
         gr90FFE2Lh0Ow4BkLBdQjC5tDh7kEgWrPW4C6KICfiz0kEK3uapNJD2p97nXP9y8uQit
         TsRxQUFJKI+fAXu7B1EtqsUtaix/Kg63TV62xnIHkJ1oXtuCGNwUhBsvpk6s1Gjh2UVu
         61hSFbCyBn2syu8Cg6odKCelHJG9AXdcglS6vvkWPa2pD2cBMD28nOWYl6J6FROH3mjP
         tV6HhdSzx7JNfcsU3/m1zOTg3r6KWyZ2lNFVSelINz3x84RE3MgpVJEW7cC+kkC/iWRL
         JRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699983550; x=1700588350;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biflnm0/tB6oVZIwXHCeBF9Ow+KXiRG6M0c54wS4tQY=;
        b=prDM1XD4GoZeUXs7tn7hoz3DOV7P4g6jCRbNMeqWQZ1Brf+4caH2Zaks1BSJygjA6G
         D5EJYh+58ytI8ieabQQqMFf4VkbsYFSlj/nWFC+IGVR0aRJLJtjXysjxrN5BHGAc6ehV
         g9GBCfi/tq8RIfh0L407sbkFGIl6QT7GFmTCxGKLLt/HewECf4pBXmhcD6ENGgT63+h6
         1ditTyIZML7BubHGlOCo9obG4L7j94tPWfEw2MRivlyylrxlMcDt3XQxJnZuGDUmMuTM
         NslbZoOo4sIWIBzyKjpNBJBRvCw4bnW6CyCMyY5y+fdSnEwECpq3UDqTkruYi6U80dGA
         QK+Q==
X-Gm-Message-State: AOJu0YwjMIZXh99bV1TA7jDHfDN3RCpUiG9ad/JzjfvAHOUxgj1wB864
	pPb/aNuvvv7MyK9/AnT+sJo2w20LpBw=
X-Google-Smtp-Source: AGHT+IGUgWVsMXZWTjIs8bJaBu0SMw5RVdALlr3NVHP45Vijg1gt8vNAfgrO+XVH+I2wedO0hGKoWQ==
X-Received: by 2002:a0c:fd43:0:b0:671:fcd3:1cc2 with SMTP id j3-20020a0cfd43000000b00671fcd31cc2mr2667152qvs.65.1699983550611;
        Tue, 14 Nov 2023 09:39:10 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id dl15-20020ad44e0f000000b006709b9f0a72sm3051942qvb.22.2023.11.14.09.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 09:39:10 -0800 (PST)
Message-ID: <a9b81f8e-a0d4-4b1d-9afb-a33cf9d27767@gmail.com>
Date: Tue, 14 Nov 2023 09:39:08 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] netdev: disambiguate between disconnection types
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231114171455.1108856-1-denkenz@gmail.com>
 <20231114171455.1108856-11-denkenz@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20231114171455.1108856-11-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,

On 11/14/23 9:14 AM, Denis Kenzior wrote:
> There are generally three scenarios where iwd generates a disconnection
> command to the kernel:
>    1. Error conditions stemming from a connection related event.  For
>       example if SAE/FT/FILS authentication fails during Authenticate or
>       Associate steps and the kernel doesn't disconnect properly.
>    2. Deauthentication after the connection has been established and not
>       related to a connection attempt in progress.  For example, SA Query
>       processing that triggers an disconnect.
>    3. Disconnects that are triggered due to a handshake failure or if
>       setting keys resulting from the handshake fails.  These disconnects
>       can be triggered as a result of a pending connection or when a
>       connection has been established (e.g. due to rekeying).
> 
> Distinguish between 1 and 2/3 by having the disconnect procedure take
> different paths.  For now there are no functional changes since all
> paths end up in netdev_connect_failed(), but this will change in the
> future.

I'm guessing the future changes would be to handle a CMD_DISCONNECT 
event via the connect callback?

Thanks,
James
