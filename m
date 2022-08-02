Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9B7F
	for <iwd@lists.linux.dev>; Tue,  2 Aug 2022 16:19:40 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id h125so17030266oif.8
        for <iwd@lists.linux.dev>; Tue, 02 Aug 2022 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EFmx/tMs87QfwJ6CTVQwRcj1dUzvtlny2VdRLkoxVVo=;
        b=k1+QxNJrdQAFNWwj9CgAabXlXVtSX/WO5ZEd5S+gagmvJ0NAJcutumoU5zXWqgTlGP
         PhgsSDWLvyq87ecp9Vs6DWmCxHTsfnJX6FfmFrqlX2qUvL5zSegyTNSAZCi1s5TRWVyf
         U0yGhP9DAPsTG/O6WhE3ZrEgzwF1URVv1+EwS4YXgW9mfo6M1bJsE3CR+LzTMwNx6GPL
         0WBq5zU+0AetruddhqXXTSdJ2mzL+LMsq4fluo9ibSS3zlj1o/6odhS4Q72yPZ+8VNjB
         9KWiZUtjGxh/XgaJgW34qR6JLEoyJVilg5k6SFdU5ggEs8k6kixQ9DNUFwJZRTAa21fu
         XWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EFmx/tMs87QfwJ6CTVQwRcj1dUzvtlny2VdRLkoxVVo=;
        b=i5ICFcrBzc8P1Qzuc/yRt8WJLJm3DZ2BkwKwbhp5A6D5MhClpaYQujyKhukbBxo+TE
         WoOUQ40DY4qYRmwx9alenCa9GDJmuxXF13hivWeDpqRNTNMO4EIZ6iGZz09gHzzux4Lu
         mKM+7RmVsyUog/2eYa7uHYOvvHpJiT63WSbqS6eZmdiMq0rEeG2vkBJqTExi2DFdsQFG
         OozoxJkZffvaVIWYOZxOdBV5ZLVzMt0QRGbaoBWb9ypp9TTEYgBmHaAZy/ZmX5JRWRNr
         Fdc0CKj1xMY/kghA/Ai6fsXFBXVnaFxz+MJGcuwP7lY57sB5FNZiEru1vfe7Vy95ZZuM
         gW8A==
X-Gm-Message-State: ACgBeo289Lh6hof5TVamf20YtZDa7OwBkXRzQQv7PYU7jdVq+5dBYdgM
	SjcXZ+Q3E2RqmIjpzkQojHI=
X-Google-Smtp-Source: AA6agR7Qf9SNtkm5Su0aod0KCJsiGrlGUwxoLsmQowCemlsqxOokOc5FXbqED7Jdx6sdul0T+D488g==
X-Received: by 2002:aca:111a:0:b0:33f:25e0:10f6 with SMTP id 26-20020aca111a000000b0033f25e010f6mr120297oir.44.1659457179195;
        Tue, 02 Aug 2022 09:19:39 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l6-20020a056871068600b000fb2aa6eef2sm1612910oao.32.2022.08.02.09.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 09:19:38 -0700 (PDT)
Message-ID: <ab74cfbd-251f-a77b-e46c-b2c97c737674@gmail.com>
Date: Tue, 2 Aug 2022 11:11:57 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] netdev: Add logging for CQM messages
Content-Language: en-US
To: Michael Johnson <mjohnson459@gmail.com>, iwd@lists.linux.dev
References: <20220802104728.48628-1-mjohnson459@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220802104728.48628-1-mjohnson459@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 8/2/22 05:47, Michael Johnson wrote:
> Add extra logging around CQM events to help track wifi status. This is
> useful for headless systems that can only be accessed over the network
> and so information in the logs is invaluable for debugging outages.
> 
> Prior to this change, the only log for CQM messages is saying one was
> received. This adds details to what attributes were set and the
> associated data with them.
> 
> The signal strength log format was chosen to roughly match
> wpa_supplicant's which looks like this:
> 
> CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-60 noise=-96 txrate=6000
> ---
>   src/netdev.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

