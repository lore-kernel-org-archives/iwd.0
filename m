Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E00225D3
	for <iwd@lists.linux.dev>; Thu,  9 Nov 2023 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHqv20sy"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b3e13fc1f7so620034b6e.0
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699547759; x=1700152559; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmBzxY4HNpKjVVVsWO+lNcTn0NmJOOAY+hSEbuCvTcM=;
        b=OHqv20sy7hD4q6ngOjjqZ07c2Ya9YPI+ss1p6tbzHrGbCuteTDfp/TxUm7escTTIKP
         LsahMLy0Lhx/eun8QaCyFco8GGUkH9Ok72d/cbgyWHd96y968vJyjOkmGguCN5dxLCee
         V6czVYTfaWSshwHujwI0Ia+E9CaY98cXpbGwDdbW9hrCSvu+IyqOmuHLULXFbMw9Zce0
         dPgdVcEQD9p1nlgQ960S3boDJXwrQiT19/dl976x6PbC6eGuX4Jq7AUIjKJyC5sp3YRd
         rl2VZBWcwcHnUqb51sbdSsxx/twJegRO+jvpENs7MXS7BV3UJKDNh1gISblAnL3/qx1y
         JZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699547759; x=1700152559;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmBzxY4HNpKjVVVsWO+lNcTn0NmJOOAY+hSEbuCvTcM=;
        b=rJkN6yCu0u3r9ZWOupwyYbrSoU+aBcKFFdoj+fZR5KZsOlT8Vg+l/rIQ6XJW27jJBi
         dcsytF2YSrfQ+vZsN+FJ3t5o7yzGQ/W6N52loUG4grX/R+TeajrQr5fylSRHSo5kuq6E
         7pr5jSzb3+kOdkchpC6JQfA1QwQ/NCt4Zes9hazu5mB9RtDKzjXo1eU564bjFgmOweJ5
         SaBWstFMJodUbt1vDX9j603ZBKV+S0t9GdYYVeJnhsKZwgxYEJ8fwtnYmQtVpTVzbHyn
         TIFQ5RgWAWrNzZvJn83xwKMBrlqmF3qpXaOolku4ydjWLKHRAx+8Gbut4qBpTw1L0hAc
         RT/w==
X-Gm-Message-State: AOJu0YyMLg1/e5LBAEO+CgbbTU4+gWgWv+OHiOEGuk8oq76pkBEXXE24
	iaq7fCBANDuFIiQM4EXobtA=
X-Google-Smtp-Source: AGHT+IHuUAr+dx1jPhK45AjTFKORkzVQ0mUTBFo90sZguZJ09ndpls8YphPqoL66NwjSPA4VT9mccg==
X-Received: by 2002:a05:6871:68b:b0:1ef:b7be:e147 with SMTP id l11-20020a056871068b00b001efb7bee147mr6509114oao.11.1699547759060;
        Thu, 09 Nov 2023 08:35:59 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u17-20020a05687004d100b001eb64e95c8bsm760648oam.57.2023.11.09.08.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 08:35:58 -0800 (PST)
Message-ID: <a6d69396-b271-4324-b095-8228055de600@gmail.com>
Date: Thu, 9 Nov 2023 10:35:55 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] DPP PKEX Changes
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231108172155.2129509-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231108172155.2129509-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/8/23 11:21, James Prestwood wrote:
> v5:
>   * Separate the DPP/PKEX interfaces using a new enum
>     to distinguish which interfaces is using the dpp_sm.
>     Similarly added a refcount to the dpp_sm object so when
>     one interface goes away it won't destroy the SM for the
>     other.
>   * Removed unneeded checks on the identifier, and added
>     some:
>        - Assume utf8/null terminated when coming from DBus
>          (just check length)
>        - Validate utf8/length when coming from the peer.
>   * Enforce any user-disabled bands when generating the
>     default frequency list.
>   * Return error on Stop() if not started. This is an API
>     change, but I thought it made sense so its very clear
>     when Stop() is called on the incorrect interface.
>   * Included autotest changes.
> 

All applied, thanks.

Regards,
-Denis

