Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A11C08
	for <iwd@lists.linux.dev>; Wed, 25 Oct 2023 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5fThDoa"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e0ee4e777bso3569419fac.3
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 19:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698201577; x=1698806377; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BRPEucSC0AHUYeN8mxYGLN3gh7aT+YXpqHz1ag20Uk=;
        b=M5fThDoall3phvMVCv6u+yF08+wigxYsqtkWwKk9qzAFFLKhfcMNZ70LhAqDFdaTf8
         ZSbp/5EOYWMRdElSI+9uQFZTEgGk8fdBzib6NNglFRCX2aKa8b5gxxdDCGsRzQtz+5Af
         4OPcv62QZFCyULVWNtxoc/04eqLMYqD+dQuQ1bQgpZt8dv0PBgcFOCkeviwijOBUjqlO
         9h7RlqfEutS425ioIsKWneRsAmYWlpc3ZfF48qaUquta5AEfCPLxSWMnWlMiA5GXWB/6
         oGYVDmx5Vspp/YzzeJgGdCyqNQwoRwYYD3fzF9VzV3le3vQPx5ooPVZq+2OoukS3ZdqP
         3VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698201577; x=1698806377;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BRPEucSC0AHUYeN8mxYGLN3gh7aT+YXpqHz1ag20Uk=;
        b=YBk2VvhKRQZrDmXwFUYCkgn7rvfI8XrIXsu8Wb88CvypZ+f2u7U8z+YU3HLjDlkLFT
         Uvt6UZUIdqieBRBgsDhs1QAyhkNPSeYv0yAk3jSZ4PWutFscuHC+sRB2nqVctT+3DnYc
         PGGS2aXdh6/8tVhkOg8O1+sfHZ/lX/3YIHqCzAnqjzGptFy6m8m4seWg1JNq5H+l71ru
         IW14ed+Lvr1w/ME1/n5bKI8A3t0Z2C+RAwIlcXX/XzBJ+CylGSGJ6XIWWHZlSh7IEzX2
         OUGGZ0tpfbzupYlswy/E5x/FtHkapEcXKQIVN7MbjWhahc2gXw9SaZu1Q4WTE/EJ2eCN
         Xazw==
X-Gm-Message-State: AOJu0YxWiSifX+VMTzkEdmAeTdZ/RXDg80W+/5Rs6Sxa2fstp/KT8tEj
	0I1qlr96dMQ2iwhXNG6PnzO7F8EZklU=
X-Google-Smtp-Source: AGHT+IGb1fAjTFWOawfQsjlMqzNumVK+DkkKLBPDsMHpszICVzJkvxNkCyev6YqLdZ+G67FPEZzUJw==
X-Received: by 2002:a05:6871:d0a:b0:1e9:9d3d:a96a with SMTP id vh10-20020a0568710d0a00b001e99d3da96amr16986220oab.41.1698201577381;
        Tue, 24 Oct 2023 19:39:37 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y1-20020a056870e50100b001e988bf0ab0sm2426365oag.3.2023.10.24.19.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 19:39:36 -0700 (PDT)
Message-ID: <a8b3caee-4f9b-4156-b0c2-e9e957897c14@gmail.com>
Date: Tue, 24 Oct 2023 21:39:33 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] offchannel: handle out of order ACKs/events
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231023122054.34100-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231023122054.34100-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/23/23 07:20, James Prestwood wrote:
> Its been seen (so far only in mac80211_hwsim + UML) where an
> offchannel requests ACK comes after the ROC started event. This
> causes the ROC started event to never call back to notify since
> info->roc_cookie is unset and it appears to be coming from an
> external process.
> 
> We can detect this situation in a few ways, first by looking up
> the offchannel info by both wdev and cookie. If found, continue
> as normal. If not lookup by only wdev and if there is still no
> roc_cookie set the cookie from the notify callback to a temporary
> 'early_cookie' placeholder and return. This can be checked in
> the ACK and if it matches we know the ACK came out of order and
> the started event can be sent.
> 
> This also handles external process case. If we got a spurious
> notify event before the ACK, the ACK callback will fail to
> verify the early cookie, set roc_cookie correctly, and the expected
> ROC event will come and issue started. Since there should be at
> most one ROC session per wdev we can assume the temporary
> early_cookie won't be overwritten.
> 
> Another minor change was made to the lookup on the cancel path.
> Instead of looking up by wdev, lookup by the ID itself. We
> shouldn't ever have more than one info per wdev in the queue but
> looking up the _exact_ info structure doesn't hurt in case things
> change in the future.
> ---
>   src/offchannel.c | 73 ++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 65 insertions(+), 8 deletions(-)
> 
> v2:
>   * Skip started if the event came early, and start in the ACK
>   * Add check for roc_cookie && roc_cmd_id in notify event. This
>     verifies that we actually have a pending request, if not it
>     came externally.
>   * Add 'early_cookie' placeholder to guard against the case of an
>     external event coming before the ACK. Prior, this would have
>     set roc_cookie to an incorrect cookie and called the started
>     callback prematurely.
> 

<snip>

> @@ -98,9 +118,19 @@ static void offchannel_roc_cb(struct l_genl_msg *msg, void *user_data)
>   		goto work_done;
>   	}
>   
> -	/* This request was cancelled, and ROC needs to be cancelled */
> +	/*
> +	 * If this request was cancelled prior to the request ever hitting the
> +	 * kernel, cancel now.

This comment makes no sense.  If we're here, then the request hit the kernel as 
best we can tell (it was sent on the socket).

> +	 *
> +	 * If the ROC event came before the ACK, call back now since the
> +	 * callback was skipped in the notify event. There is the potential that
> +	 * an external process issued the ROC, but if the cookies don't match
> +	 * here we can be sure it wasn't for us.
> +	 */
>   	if (info->needs_cancel)
>   		offchannel_cancel_roc(info);
> +	else if (info->early_cookie == info->roc_cookie && info->started)
> +		info->started(info->user_data);
>   
>   	return;
>   
> @@ -191,7 +221,8 @@ void offchannel_cancel(uint64_t wdev_id, uint32_t id)
>   	else if (ret == false)
>   		goto work_done;
>   
> -	info = l_queue_find(offchannel_list, match_wdev, &wdev_id);
> +
> +	info = l_queue_find(offchannel_list, match_id, &id);
>   	if (!info)
>   		return;
>   

So I split this chunk out into a separate commit and applied this.  Please 
double check that I didn't screw anything up.

> @@ -246,6 +277,7 @@ work_done:
>   static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
>   {
>   	struct offchannel_info *info;
> +	struct match_data match = {0};
>   	uint64_t wdev_id;
>   	uint64_t cookie;
>   	uint8_t cmd;
> @@ -261,12 +293,37 @@ static void offchannel_mlme_notify(struct l_genl_msg *msg, void *user_data)
>   					NL80211_ATTR_UNSPEC) < 0)
>   		return;
>   
> -	info = l_queue_find(offchannel_list, match_wdev, &wdev_id);
> +	match.wdev_id = wdev_id;
> +	match.cookie = cookie;
> +
> +	info = l_queue_find(offchannel_list, match_info, &match);
> +	if (!info) {
> +		/* Try again without cookie */
> +		match.cookie = 0;
> +		info = l_queue_find(offchannel_list, match_info, &match);
> +	}
> +

I think this can be further nailed down as follows:

- Search by cookie, wdev and info->roc_cmd_id being 0.  That is our 'normal' 
case where we sent the ROC, get the ack, and the ROC event comes in.  Handle it 
normally and return.

If that fails, then search by wdev, info->rcmd_id_id != 0 and 
l_genl_family_request_sent is true.  If you don't find anything, then this 
request is from outside iwd.  This logic might be better as a for loop based on 
l_queue_get_entries().

Otherwise, set the early_cookie and return.

>   	if (!info)
>   		return;
>   
> -	/* ROC must have been started elsewhere, not by IWD */
> -	if (info->roc_cookie != cookie)
> +	/*
> +	 * If the cookie is zero and there is a pending ROC command there are
> +	 * two possibilities:
> +	 *   - The ACK callback came out of order. This has been seen in UML
> +	 *     when an offchannel request is canceled followed by another
> +	 *     request on the same channel. To handle this delay the started
> +	 *     callback until the ACK comes in when we can check the cookie.
> +	 *
> +	 *   - Event came from external process doing ROC. Checking the cookie
> +	 *     in the ACK lets us verify if this is the case.
> +	 *
> +	 * If the cookie is set but does not match, this ROC request came from
> +	 * outside IWD.

This last sentence probably belongs in the "If you don't find anything" part above.

> +	 */
> +	if (!info->roc_cookie && info->roc_cmd_id) {
> +		info->early_cookie = cookie;
> +		return;
> +	} else if (info->roc_cookie != cookie)

What does this do?

>   		return;
>   
>   	switch (cmd) {

Regards,
-Denis
