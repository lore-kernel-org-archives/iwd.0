Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D6612E58
	for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8OZ1aph"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1efa01323b4so1040921fac.3
        for <iwd@lists.linux.dev>; Sun, 29 Oct 2023 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698618545; x=1699223345; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGxJuz6iC6lgeXHPIzbSqINFrMXBODi3E/ElAFniIvs=;
        b=B8OZ1aphElir9yLA/n5MX4MtTJPhQaqBGoCEJXVX3SkyskH9pBIlE/4JaAwK0zsOG4
         TQnOOVaJrkdQlpWesqKC3mDIjSdbka0p+WMdmh3lr3xHu/tJeRdp6G6egANvZE72E7rP
         ffs7PpSmbcg7tR3X0IJijdCIcsITWH6bRd7pNqDnlUw/EADce6NoABl8bhEgn5vP2njK
         W4d7nnk4YX6FU3XeJuCJH5oyGCz6GlVD7uejo3m+gaumNe/Srrstj/q/VfNGLO7D+sAC
         iX9ypq23EvRA5tlgsbe7752tg7ubNuNgUEifAZ+13mcslp05fxcbkW1wl/igC2WfiT8i
         3ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698618545; x=1699223345;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGxJuz6iC6lgeXHPIzbSqINFrMXBODi3E/ElAFniIvs=;
        b=q3U4jpssFwMkeuLupWUYeRnvCNgd5yw5TJ/z7g298TkBef582P8sQdx8/7k1sIwc2h
         lpJGgAvbnU0Jar8aiWVvfvwOK/gXj5lew1Lfc8piIWZAReawZCkrV8fIuM9hqFOBBKnx
         vrtIQkod+MZIthF75KxOc7YZM81PPbkoTI1evYEPCe8vJpCKNzmUdEZ6btjSPbufBycV
         8sqBpzULAOeGdFj2a+RNC0TnPkQKK7lZ8N/oFo20XKpf6CilkPXr/dWUgSprThU3cQ17
         bo52oMU1CCt7Ne9lg2oq+GPVt9wayCTrtjN4KMUmgUtydZ0LINC67zJvlXvl/YyRIGMB
         O7Ng==
X-Gm-Message-State: AOJu0YxpNuLwSc7W14NtgcMg4Wtl2EFthoLh127XdyPfajU8mKLi59pB
	1pRIIx73EdaJVNK753kZlc8=
X-Google-Smtp-Source: AGHT+IFaYPeOxhD3mJ6PlatPC9dy+3AwXFrR0iVM74A/ojTeBZ+CnM96q4R0X2PisUqkNALcOTS1dw==
X-Received: by 2002:a05:6870:120f:b0:1ef:abaa:cae0 with SMTP id 15-20020a056870120f00b001efabaacae0mr4523463oan.29.1698618545124;
        Sun, 29 Oct 2023 15:29:05 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id g21-20020a056870c39500b001efce0658e6sm402451oao.39.2023.10.29.15.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 15:29:04 -0700 (PDT)
Message-ID: <cfc039db-64e5-431e-9d66-7e97f2214dda@gmail.com>
Date: Sun, 29 Oct 2023 17:29:04 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] dbus: add SharedCodeDeviceProvisioning interface
 definition
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231026202657.183591-1-prestwoj@gmail.com>
 <20231026202657.183591-14-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231026202657.183591-14-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/26/23 15:26, James Prestwood wrote:
> ---
>   src/dbus.h | 1 +
>   1 file changed, 1 insertion(+)
> 

Applied, thanks.

Regards,
-Denis

