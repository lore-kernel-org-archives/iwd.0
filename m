Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB51363
	for <iwd@lists.linux.dev>; Fri, 10 Nov 2023 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4NtHzTm"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so850286a34.2
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 18:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699582675; x=1700187475; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnazQ1OZd/9Lg2vw0lWieikeG/quatRa0Uh3RMPhL+k=;
        b=O4NtHzTmyLKBY3wIqQ+XRYqSYUDdi83TVdA8eOCk9cPzqYinjjADKDLslslSQL8ljX
         OZHdGB45eegAWapb3Nm1/9YCEfF2oAFflUx/k8FM/q2xXJVKbmdtA5vtI3QVIM7BR4m3
         TsOKnB+9gkUs+mEsbJXoBA6WHj7ZUUB1k2Mq9+RN3sJdR9RmMphVjo/vDw2SptJ96mQX
         PUdvQVKOBAaQQODHnFhr2cblVjFIiz6/iRCAW4/OXHJ53vRy250RMUfYk/novCl0LuPq
         Bw5uw6V91BZF8xDtTU+zpZOf7lsWh8mO+qVu1eWSHEH4N2OpI5aM3AOtPmn/9npc5uLW
         6tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582675; x=1700187475;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnazQ1OZd/9Lg2vw0lWieikeG/quatRa0Uh3RMPhL+k=;
        b=vyKkZru/c1eQaQ/V1P8LBp4QUD546yAfm+SZQRHX0ff0MAHxlNgypsb8JxVWUKm59b
         96RGBim2gK8vXPCdTaxkS5iHdGeQC4Z2vEbxtD67C2XvcC7L4nCESzb+Z45QD2WxBxxa
         0mPwY6xfL0r86CXQOophUbXoXgzMjV0RTPEVRDxryU6eZHpPYjqgrMNrj6DjSp/AH1cP
         FDyO+V67msJpNBFQd5lWUBgPdlzyaE+/SnHAlBRB/4nuIeW48cVZtXVmypg6GVo+2ady
         i/he3QhbpUiv1y93PRiTAZAwYtfebhkJcIbEEHpgR0UT9gtBNEnSxs6saXjXKIVwXM4B
         yt8A==
X-Gm-Message-State: AOJu0YzQh5JNRLj13W7/4iQcByZBgFf0wOji6P2X3cTYEZqsS/OAnFlB
	7Sk+py2Q6LnS7kK9WkgIcxY1Ttf2GRY=
X-Google-Smtp-Source: AGHT+IHreJN5tjGp2izsKOMICe+mbxF1OazbxpX/we5t3h7g6v0vViphspelfwbEC7o+uAVLM1FVrw==
X-Received: by 2002:a05:6830:12c2:b0:6bf:1444:966d with SMTP id a2-20020a05683012c200b006bf1444966dmr6753207otq.1.1699582674865;
        Thu, 09 Nov 2023 18:17:54 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t26-20020a05683022fa00b006ce2fce83cbsm2432173otc.25.2023.11.09.18.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 18:17:54 -0800 (PST)
Message-ID: <8d34f4e5-3c21-44b6-baf2-78420258bab8@gmail.com>
Date: Thu, 9 Nov 2023 20:17:54 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] client: Add shared code DBus interface
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231109184926.52629-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231109184926.52629-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/9/23 12:49, James Prestwood wrote:
> ---
>   client/dbus-proxy.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
> index 0b4fec43..cd1b2305 100644
> --- a/client/dbus-proxy.h
> +++ b/client/dbus-proxy.h
> @@ -2,7 +2,7 @@
>    *
>    *  Wireless daemon for Linux
>    *
> - *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2017-2013  Intel Corporation. All rights reserved.

Uh?

>    *
>    *  This library is free software; you can redistribute it and/or
>    *  modify it under the terms of the GNU Lesser General Public

Regards,
-Denis

