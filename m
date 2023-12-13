Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C521D52D
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTYypAko"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ba04b9b103so3013023b6e.0
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702483616; x=1703088416; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8QJjX1LOBPphoIwT8mLQG5e0T600AtMgNMSzkG8z/w=;
        b=MTYypAkoy6jK+4HGawii+uIOwBTo6HNc/VrxsrNezsoUxyLe6HRQn4+V+2vk0nffh/
         ODpdEEiX26Mh3g07qPprnmVURrFCKVnI6SBbFMBa2X1UDMdx8BLkBjTDnIDC156d6N3G
         XDo9+I1qfGcffQxJPnZmN5wN1oQl7XIGA5oEsXSjPNfZ06AxHMfAcCrrY3Ao5G6wXb4g
         oi6H/1pDkKaktQSgYsR3oNY87qbKmdZSBMHHiEMITSIhbPgUso5UBO8wj4ZMjJ0+x5HF
         2MaUSUn81Dd+EDM7qAJM3VtS8RVw23qxTn1gxqzdUoLyTyHKDt3KIxl+7hojFd/zM1ay
         6RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483616; x=1703088416;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8QJjX1LOBPphoIwT8mLQG5e0T600AtMgNMSzkG8z/w=;
        b=Q9+Zfd7Eofpn9R5an7w2PsD79p6RdeJ4hmjRWGCBU3Xc2xUIf34Tn3NBN9G2pFri/G
         5K2XIScRmFvWQHXhkq9jWkhBkmQanYeq+eaVj78xWToQKjZpdy+MuGDWoN6alOwFJ9EZ
         7PN3/5VseTHzpPv/0qmw01CxC0BYaCQHdef61+ENzEN7yRdO+HDNDjSmhfWUtKSISe/r
         9EuirtsJ8XShOtRl3ifN+Vg61K2sDqoJW5Szglmeg90tZnvdXAE1N52QBMX1z9F0WmLv
         iXup6qXJskXDH1TXEbSPY8Zi7YyaQ3WWz+NMrmddk5M14Y1rjS3XmwhIwk5rssPD59dP
         KIqQ==
X-Gm-Message-State: AOJu0YxjW2gfk+8hhjg+vkN4TDgw9Iw5HnwGLYC1NxV6XNIhalUrogO/
	2v2lzKn7K6/D0bHCQq9IuorEjrF50TI=
X-Google-Smtp-Source: AGHT+IFZ2bGPEA3D4pGposLxno6Lw5uMh8z59hFXaxwq75YyTHambOvWnsyn/BUybbt7IPIZNQx6Aw==
X-Received: by 2002:a05:6808:1642:b0:3b9:efe8:b9f0 with SMTP id az2-20020a056808164200b003b9efe8b9f0mr10647595oib.55.1702483616049;
        Wed, 13 Dec 2023 08:06:56 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e9-20020a05680809a900b003b8b1a4fbf9sm3009191oig.31.2023.12.13.08.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:06:55 -0800 (PST)
Message-ID: <5aa0f369-b5c1-44b4-a54c-f7e25d5fd506@gmail.com>
Date: Wed, 13 Dec 2023 10:06:55 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] auto-t: fix SignalAgent Release arguments
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231211194120.64625-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231211194120.64625-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/11/23 13:41, James Prestwood wrote:
> The path for IWD to call this doesn't ever happen in autotests
> but during debugging of the DPP agent it was noticed that the
> DBus signature was incorrect and would always result in an error
> when calling from IWD.
> ---
>   autotests/util/iwd.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

