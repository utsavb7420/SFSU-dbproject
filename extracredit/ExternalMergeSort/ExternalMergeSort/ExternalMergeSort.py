#!/usr/bin/python

import os
import sys
import tempfile


class HeapNode:
    """
    HeapNode DataStructure
    """

    def __init__(self, item, file_handler):
        self.item = item
        self.file_handler = file_handler


class ExternalMergeSort:
    def __init__(self):
        self.sorted_temp_file_handler_list = list()
        self.cwd = os.getcwd()

    def write_to_file(self, sorted_data):
        with open("sorted_age.txt", "w") as myfile:
            for item in sorted_data:
                myfile.write(str(item) + ",")

    def heapify(self, arr, i, n):
        left = 2 * i + 1
        right = 2 * i + 2
        if left < n and arr[left].item < arr[i].item:
            smallest = left
        else:
            smallest = i

        if right < n and arr[right].item < arr[smallest].item:
            smallest = right

        if i != smallest:
            (arr[i], arr[smallest]) = (arr[smallest], arr[i])
            self.heapify(arr, smallest, n)

    def construct_heap(self, arr):
        l = len(arr) - 1
        mid = l / 2
        while mid >= 0:
            self.heapify(arr, int(mid), l)
            mid -= 1

    def merge_sorted_temp_files_low_level(self):
        node_list, sorted_output = list(), list()
        for temp_file_handler in self.sorted_temp_file_handler_list:
            item = int(temp_file_handler.readline().strip())
            node_list.append(HeapNode(item, temp_file_handler))

        self.construct_heap(node_list)
        while True:
            min = node_list[0]
            if min.item == sys.maxsize:
                break

            sorted_output.append(min.item)
            file_handler = min.file_handler
            item = file_handler.readline().strip()
            if not item:
                item = sys.maxsize
            else:
                item = int(item)

            node_list[0] = HeapNode(item, file_handler)
            self.heapify(node_list, 0, len(node_list))

        return sorted_output

    def split_files(self, file_name, page_size):
        pass_number, files_number, buffer_number = 0, 0, 0
        large_file_handler = open(file_name)
        temp_buffer = list()
        size = 0

        if not os.path.exists('temp'):
            os.makedirs('temp')

        while True:
            number = large_file_handler.read(400)
            if not number:
                break

            while not number.endswith(","):
                buffer_number = buffer_number + 1
                number = number + large_file_handler.read(4)

            number = number.split(",")
            for n in number:
                if not n == '':
                    temp_buffer.append(n)

            size += 1
            if size % page_size == 0:
                temp_buffer = sorted(temp_buffer, key=lambda no: int(no.strip()))
                temp_file = tempfile.NamedTemporaryFile(dir=self.cwd + '/temp', delete=False)
                temp_buffer = [f"{t}\n" for t in temp_buffer]
                temp_buffer = [t.encode() for t in temp_buffer]
                temp_file.writelines(temp_buffer)
                temp_file.seek(0)
                self.sorted_temp_file_handler_list.append(temp_file)
                temp_buffer = list()
                files_number = files_number + 1

            print(f"{pass_number}, {buffer_number}, {files_number}")
            pass_number = pass_number + 1


if __name__ == '__main__':
    large_file_name = 'age.txt'
    page_size = 800
    obj = ExternalMergeSort()
    obj.split_files(large_file_name, page_size)
    sorted_data = obj.merge_sorted_temp_files_low_level()
    obj.write_to_file(sorted_data)
