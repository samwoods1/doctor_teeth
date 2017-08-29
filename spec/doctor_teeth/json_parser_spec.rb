require 'spec_helper'

module DoctorTeeth
  describe NewLineJsonFileParser do

    shared_examples 'missing file' do
      it 'should exit gracefully' do
      end
    end
    shared_examples 'found file' do
      it 'should exit successfully' do
      end
    end
    shared_examples 'missing data' do
      it 'should exit gracefully' do
      end
    end
    shared_examples 'suite durations' do
      it 'should exit successfully' do
      end
      it 'should have all durations' do
      end
    end
    shared_examples 'job configs' do
      it 'should exit successfully' do
      end
    end
    shared_examples 'generate_json' do
      it 'should exit successfully' do
      end
    end
    shared_examples 'generate_multiple_json' do
      it 'should exit successfully' do
      end
    end

    context 'single file' do
      let(:file) { 'some_missing_file.json' }
      it_behaves_like 'missing file'
      context 'empty' do
        let(:file) { 'some_missing_file.json' }
        it_behaves_like 'missing file'
      end
      let(:file) { 'some_file.json' }
      it_behaves_like 'found file'
      let(:file) { 'missing_data.json' }
      it_behaves_like 'missing data'
    end
    context 'single dir' do
      let(:file) { 'some_missing_file.json' }
      it_behaves_like 'missing file'
      context 'empty' do
        let(:file) { 'some_missing_file.json' }
        it_behaves_like 'missing file'
      end
      let(:file) { 'some_file.json' }
      it_behaves_like 'found file'
      let(:file) { 'missing_data.json' }
      it_behaves_like 'missing data'
    end
    context 'globbed files' do
      let(:file) { 'some_missing_file.json' }
      it_behaves_like 'missing file'
      let(:file) { 'some_file.json' }
      it_behaves_like 'found file'
      let(:file) { 'missing_data.json' }
      it_behaves_like 'missing data'
    end
    context 'globbed dirs' do
      let(:file) { 'some_missing_file.json' }
      it_behaves_like 'missing file'
      let(:file) { 'some_file.json' }
      it_behaves_like 'found file'
      let(:file) { 'missing_data.json' }
      it_behaves_like 'missing data'
    end
  end
end
