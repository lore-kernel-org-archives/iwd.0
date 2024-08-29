Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FA2F5E
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724904807; cv=none; b=MCBEXjD1ijtO3BRp7dSocO147XIzlbUYwbFqYVw+7ec24Qk1C+0YGCDR/1zV6CyN5+SX+qw22/6Ek8DrXSAgYItjSYGszKOESE7PhXIbr8kuqGi3bpehrmFCUBAvEybr0Yxs43VFD9VMA+/XKy6e2GcQca/6r+E99UrGp5IDKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724904807; c=relaxed/simple;
	bh=izFXp182UxR4NDOz4zYWRNX6c0FvnKvyPWH41H4dP0M=;
	h=From:Message-ID:Date:MIME-Version:To:Subject:Content-Type; b=HHjcPeQ42XoQhWyOrZjyDM3g4A8urpUAp52Ge5IKF+EnqNzfaG3JC5MR2BwIG1mSYsScfXF4AQR+bltkTdRFa9vbpHd61UcKDdtYjqXiDIMtlFmOhzG46xE0C56WJGhCotsEzYt2WcPBiKZzxV+/ZU0oN+5+sTTrd1eEjr5TJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isWJdVu6; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isWJdVu6"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71456acebe8so194569b3a.3
        for <iwd@lists.linux.dev>; Wed, 28 Aug 2024 21:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724904804; x=1725509604; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:to:content-language:reply-to
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5g/cdCa6lsUsIR896g1w6Pdocw7hrqtLgMOIEfjjvU=;
        b=isWJdVu6PHyA8399PSHze0vXJp+E8XyMc6knW7i6cX5E0AMc78VB1XBB8S+LgpZoao
         1vq5gSYpA02b0Nu1aufdTudcsaF/9lf/mCUrP4Pol9r6oz0Np5j4rUih/pnWzZ+aiVLP
         mgeIZS2kKWfWN6tSEef9u4KkE3yrd4ohLb8BEO9OfObv3IhC1JXI7GWnD6lCZXlJd6V5
         WzEhrn/NMd4aJiUaJs+haxMLBhMk3GQcgjBWkp1ImEhrORnUn2B6nD6EBDCrODzel0RM
         WbjNJjVt0xCSWjpKTLq+CmW+TWOX96G5GpKNgkcxN2Xrua27HIqYgH0eCaOJAxHf/Ryi
         fQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724904804; x=1725509604;
        h=content-transfer-encoding:subject:to:content-language:reply-to
         :user-agent:mime-version:date:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5g/cdCa6lsUsIR896g1w6Pdocw7hrqtLgMOIEfjjvU=;
        b=Hw94f9AYlnt4dKzR8Gt7yQkLGHHA+qzB+/psWz7KdMmX+ycL0CWH0N7djIRastWOmO
         n7iiyByQ+sGQTfDzUtnDgpbw0GZl08lgncsXb25AF2ZHhWr7DgjjoLhaAfELMaFVkdAW
         u+pekJsH0wQBSU0LylL6NWEXhMv6oHBtFBdqDQZB0KQdzuzqkzApAigza/+XIuZDBXXQ
         +cNyeVQdd1XKSLKHgb99A6kEa+r99t30EcMu3zdRFMEhQzfdMUHTj9a8cYOCO4pycJDg
         3CJsegqABgSlonp7LfzbRyGytrcWbuvet1FYUQrX+4U+cYoFD9DtPKxciHEZ1cFiPR8i
         EIfw==
X-Gm-Message-State: AOJu0YzTDlUobtnY885pYcgQX8HUhFM0jT0/SAYDWM78QJVctWJtixSg
	RcCIS0adZHgr8fYulE+bjJmLtSnJa4flpA1WUKffeLaDBwUYmT0BUXj4EUznloE=
X-Google-Smtp-Source: AGHT+IF4+PdDqHPTFxiASdE3Ad+MP1+5jNLQigUjKY16L4YF13thvC8AHEXfNNiSNO4VNwl1boJQug==
X-Received: by 2002:a05:6a00:4fc9:b0:706:6408:7917 with SMTP id d2e1a72fcca58-715dfc7629dmr1767429b3a.26.1724904803763;
        Wed, 28 Aug 2024 21:13:23 -0700 (PDT)
Received: from [192.168.0.154] ([115.187.48.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e7814b0sm303506a12.47.2024.08.28.21.13.22
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 21:13:23 -0700 (PDT)
From: bbhtt <bbhtt.zn0i8@gmail.com>
X-Google-Original-From: bbhtt <bbhtt.zn0i8@slmail.me>
Message-ID: <520f3ed2-79fe-4b91-9442-b219cb00732a@slmail.me>
Date: Thu, 29 Aug 2024 09:43:19 +0530
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: bbhtt.zn0i8@slmail.me
Content-Language: en-GB
To: iwd@lists.linux.dev
Subject: Build failure with GCC 14
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello I'm seeing a few build failures when building with GCC 14. Not sure what 
would be the place to report these.

```
monitor/main.c: In function ‘genl_lookup’:
monitor/main.c:328:30: error: passing argument 2 of ‘l_netlink_send’ makes 
pointer from integer without a cast [-Wint-conversion]
   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
       |                              ^~~~~~~~~~~~
       |                              |
       |                              int
In file included from ./ell/ell.h:17,
                  from monitor/main.c:43:
./ell/netlink.h:34:59: note: expected ‘struct l_netlink_message *’ but argument 
is of type ‘int’
    34 |                                 struct l_netlink_message *message,
       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
monitor/main.c:328:52: error: passing argument 5 of ‘l_netlink_send’ makes 
pointer from integer without a cast [-Wint-conversion]
   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
       |                                                    ^~~~~~~~~~~
       |                                                    |
       |                                                    long unsigned int
./ell/netlink.h:37:58: note: expected ‘l_netlink_destroy_func_t’ {aka ‘void 
(*)(void *)’} but argument is of type ‘long unsigned int’
    37 |                                 l_netlink_destroy_func_t destroy);
       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
monitor/main.c:328:9: error: too many arguments to function ‘l_netlink_send’
   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
       |         ^~~~~~~~~~~~~~
./ell/netlink.h:33:14: note: declared here
    33 | unsigned int l_netlink_send(struct l_netlink *netlink,
```

Thanks!

-- 
- bbhtt

https://bbhtt.github.io/

