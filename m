Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395E17BAB
	for <iwd@lists.linux.dev>; Mon, 25 Mar 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387573; cv=none; b=SvzszFPbDtho3reAY4CocZw0MI0qQcvybyHj/jeRwkNN+w50wTMcjEZpsVpnCYDnVqpCaFG4gcJrjioowLbRd6EOw2vj75OTjXBN6fWWVvPORgtYJ2/23vJWwk6zuW8p8IEllOJwRVD5Oeai1QU9xV28UPUre+/iwmX3xXCzLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387573; c=relaxed/simple;
	bh=4c96cP52Jcisq4O2sXae4VvdzUShSPS8ypLt+FY9+gk=;
	h=From:Content-Type:Date:Cc:To:MIME-Version:Message-ID:Subject; b=Tv1VG7wK3hlf/DB9ye3neZTWvHJSGXBcHU0gBb04ZBF0MsfQHvX6WOdr/TGSqoNp55voZNmYSf0bX0s5KzdCy2dzPjdkerEwWznT0fWp2z1NuCFLuNMFqLnHwDdOQeOcXr69IY+pS6FnM2vvYnzTZ+JEe9lwC+3MUNTzDG2rVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 60C8A37810C0;
	Mon, 25 Mar 2024 17:26:09 +0000 (UTC)
From: "Jeremy Whiting" <jeremy.whiting@collabora.com>
Content-Type: multipart/mixed; boundary="----=_=-_OpenGroupware_org_NGMime-2602023-1711387569.171470-2------"
X-Forward: 127.0.0.1
Date: Mon, 25 Mar 2024 17:26:09 +0000
Cc: "Edmund Smith" <ed.smith@collabora.com>, "Alvaro Soliverez" <alvaro.soliverez@collabora.com>
To: iwd@lists.linux.dev
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <27b427-6601b380-b-46ef6f80@167641064>
Subject: ios hotspot fix
User-Agent: SOGoMail 5.10.0

------=_=-_OpenGroupware_org_NGMime-2602023-1711387569.171470-2------
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Length: 1631

Hello,

In recent testing it has been found that when trying to connect to an i=
os hotspot some messages are missed by iwd. It seems to be a timing iss=
ue, doesn't happen every time, but does happen often enough to be a pro=
blem. In testing the device fails to connect more than half of the atte=
mpts.

Ed Smith has created a patch that seems to fix the problem here. I've a=
ttached the patch after rebasing on iwd master.

Here's a bit of background and explanation:

iwd has difficulty in connecting to iOS hotspots as of 2.7 (and not
fixed according to our testing as of 2.16 - latest at the time this is
done). This is because of several factors:


The iOS hotspot does not repeat its initial EAPOL challenge, where
most APs will.


The iOS hotspot is not reactive to EAPOL-Start (client request to be
challenged); it sends exactly one challenge, and then the connection
times out.


The iOS hotspot sends its challenge very quickly, more quickly than
iwd is prepared for. iwd is not ready to receive the challenge
packet before the association event is fired by the kernel's wifi
stack, but the iOS hotspot's challenge packet consistently arrives
before this.


This patch moves iwd's frame listener registration for EAPOL back to
the authenticate event fired by the kernel. At this point, the
necessary details about what kind of connection we expect to have
(e.g. are we an AP) are available, but it's not possible for any
plausible EAPOL packet to arrive yet (because authenticate requires us
to take action - EAPOL happens after association, which can't happen
before we respond to authenticate).

thanks,
Jeremy

------=_=-_OpenGroupware_org_NGMime-2602023-1711387569.171470-2------
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Register-EAPOL-frame-listeners-earlier.patch"
Content-Length: 2153

RnJvbSBiMTkwMDc0MzEzMTFlNWYzZmUxY2Q0ZTQxNDllYzkwOWM0ZTU3ZmZiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBFZCBTbWl0aCA8ZWQuc21pdGhAY29sbGFib3JhLmNv
bT4KRGF0ZTogVGh1LCAyMSBNYXIgMjAyNCAyMTo0Mzo1NyArMDAwMApTdWJqZWN0OiBbUEFU
Q0hdIFJlZ2lzdGVyIEVBUE9MIGZyYW1lIGxpc3RlbmVycyBlYXJsaWVyCgpJZiB3ZSByZWdp
c3RlciB0aGUgbWFpbiBFQVBPTCBmcmFtZSBsaXN0ZW5lciBhcyBsYXRlIGFzIHRoZSBhc3Nv
Y2lhdGUKZXZlbnQsIGl0IG1heSBub3Qgb2JzZXJ2ZSBwdGtfMV9vZl80LiBUaGlzIGRlZmVh
dHMgaGFuZGxpbmcgZm9yIGVhcmx5Cm1lc3NhZ2VzIGluIGVhcG9sX3J4X3BhY2tldCwgd2hp
Y2ggb25seSBzZWVzIG1lc3NhZ2VzIG9uY2UgaXQgaGFzIGJlZW4KcmVnaXN0ZXJlZC4KCklm
IHdlIG1vdmUgcmVnaXN0cmF0aW9uIHRvIHRoZSBhdXRoZW50aWNhdGUgZXZlbnQsIHRoZW4g
dGhlIEVBUE9MCmZyYW1lIGxpc3RlbmVycyBzaG91bGQgb2JzZXJ2ZSBhbGwgbWVzc2FnZXMs
IHdpdGhvdXQgYW55IHBvc3NpYmxlCnJhY2VzLiBOb3RlIHRoYXQgdGhlIG1lc3NhZ2VzIGFy
ZSBub3QgYWN0dWFsbHkgcHJvY2Vzc2VkIHVudGlsCmVhcG9sX3N0YXJ0KCkgaXMgY2FsbGVk
LCBhbmQgd2UgaGF2ZW4ndCBtb3ZlZCB0aGF0IGNhbGwgc2l0ZS4gQWxsCnRoYXQncyBjaGFu
Z2luZyBoZXJlIGlzIGhvdyBlYXJseSBFQVBPTCBtZXNzYWdlcyBjYW4gYmUgb2JzZXJ2ZWQu
Ci0tLQogc3JjL25ldGRldi5jIHwgOCArKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zcmMvbmV0ZGV2LmMg
Yi9zcmMvbmV0ZGV2LmMKaW5kZXggMDlmYWM5NTkuLjNiNmUyYzI2IDEwMDY0NAotLS0gYS9z
cmMvbmV0ZGV2LmMKKysrIGIvc3JjL25ldGRldi5jCkBAIC0yOTE4LDYgKzI5MTgsMTEgQEAg
c3RhdGljIHZvaWQgbmV0ZGV2X2F1dGhlbnRpY2F0ZV9ldmVudChzdHJ1Y3QgbF9nZW5sX21z
ZyAqbXNnLAogCQlyZXR1cm47CiAJfQogCisJaWYgKCFuZXRkZXYtPnNtKSB7CisJCW5ldGRl
di0+c20gPSBlYXBvbF9zbV9uZXcobmV0ZGV2LT5oYW5kc2hha2UpOworCQllYXBvbF9yZWdp
c3RlcihuZXRkZXYtPnNtKTsKKwl9CisKIAkvKgogCSAqIER1cmluZyBGYXN0IFRyYW5zaXRp
b24gd2UgdXNlIHRoZSBhdXRoZW50aWNhdGUgZXZlbnQgdG8gc3RhcnQgdGhlCiAJICogcmVh
c3NvY2lhdGlvbiBzdGVwIGJlY2F1c2UgdGhlIEZURSBuZWNlc3NhcnkgYmVmb3JlIHdlIGNh
biBidWlsZApAQCAtMzA5OSw5ICszMTA0LDYgQEAgc3RhdGljIHZvaWQgbmV0ZGV2X2Fzc29j
aWF0ZV9ldmVudChzdHJ1Y3QgbF9nZW5sX21zZyAqbXNnLAogCQkJbmV0ZGV2LT5hcCA9IE5V
TEw7CiAJCX0KIAotCQluZXRkZXYtPnNtID0gZWFwb2xfc21fbmV3KG5ldGRldi0+aGFuZHNo
YWtlKTsKLQkJZWFwb2xfcmVnaXN0ZXIobmV0ZGV2LT5zbSk7Ci0KIAkJLyogSnVzdCBpbiBj
YXNlIHRoaXMgd2FzIGEgcmV0cnkgKi8KIAkJbmV0ZGV2LT5pZ25vcmVfY29ubmVjdF9ldmVu
dCA9IGZhbHNlOwogCi0tIAoyLjQ0LjAKCg==

------=_=-_OpenGroupware_org_NGMime-2602023-1711387569.171470-2--------

